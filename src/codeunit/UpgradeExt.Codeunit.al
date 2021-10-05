codeunit 50001 "UpgradeExt"
{
    Subtype = Upgrade;

    trigger OnUpgradePerDatabase()
    var
        SubscriptionMgtProxy: Codeunit SubscriptionMgtProxy;
    begin
        SubscriptionMgtProxy.AddProduct()
    end;
}