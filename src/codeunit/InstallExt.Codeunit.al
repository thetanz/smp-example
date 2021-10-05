codeunit 50000 "InstallExt"
{
    Subtype = Install;

    trigger OnInstallAppPerDatabase()
    var
        SubscriptionMgtProxy: Codeunit SubscriptionMgtProxy;
    begin
        SubscriptionMgtProxy.AddProduct()
    end;
}