from uuid import uuid4
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, Field


# instantiate our fastapi object
app = FastAPI(title="Novapay payment api", version="1.0.0")

# create a payment request class 
class PaymentRequest(BaseModel):
    """payment request model"""
    amount:float = Field(gt=0)
    currency: str = Field(min_length=3, max_length=3)

# a simple dictionary to hold payment records
payments = {}

# define health check endpoint
@app.get("/health")
def health():
    """health check endpoint"""
    return {
        "status": "healthy"
        }


# define make payment endpoint
@app.post("/payments", status_code=201)
def create_payment(payment: PaymentRequest):
    """process payment endpoint"""
    payment_id = str(uuid4())
    response = {
        "id": payment_id,
        "amount": payment.amount,
        "currency": payment.currency.upper(),
        "status":"pending"
    }
    payments[payment_id] = response
    return response


# get payments record
@app.get("/payments/{payment_id}")
def get_payment(payment_id:str):
    """get payment data"""
    payment_rec = payments.get(payment_id)

    if payment_rec is None:
        raise HTTPException(
            status_code=404,
            detail="payment record not found"
        )
    return payment_rec

