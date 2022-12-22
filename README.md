# Setup
Add your secret provider before deployment. Example: 
```
codeunit 50003 "DeveloperSecretProvider"
{
    procedure TryInitializeFromCurrentApp(): Boolean
    begin
        exit(true)
    end;

    procedure GetSecret(Name: Text; var Result: Text): Boolean
    begin
        case Name of
            'StripeSecretKey':
                Result := ''; // Your Stripe API Secret: https://stripe.com/docs/keys#obtain-api-keys
            'StripePublishableKey':
                Result := ''; // Your Stripe Publishable Key: https://stripe.com/docs/keys#obtain-api-keys
            'StripeProductID':
                Result := ''; // Your Stripe Product Identifier: https://dashboard.stripe.com/products
            else
                exit(false);
        end;
        exit(true);
    end;
}
```