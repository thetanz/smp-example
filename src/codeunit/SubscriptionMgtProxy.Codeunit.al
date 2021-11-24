codeunit 50002 "SubscriptionMgtProxy"
{
    var
        SubscriptionMgt: Codeunit SubscriptionMgt_SM_TSL;

    [NonDebuggable]
    internal procedure AddProduct()
    var
        Info: ModuleInfo;
        TryAddProductErr: Label 'Failed to register product.';
    begin
        if NavApp.GetCurrentModuleInfo(Info) then
            // https://docs.365extensions.com/docs/SM/docs/References/SubscriptionMgt#tryaddproduct-method
            if SubscriptionMgt.TryAddProduct(
                GetSecret('StripeSecretKey'),
                GetSecret('StripePublishableKey'),
                Info,
                GetSecret('StripeProductID'))
            then
                exit;
        LogError('SubscriptionMgtProxy-0001', TryAddProductErr)
    end;

    [NonDebuggable]
    internal procedure IsActive() Result: Boolean
    begin
        // https://docs.365extensions.com/docs/SM/docs/References/SubscriptionMgt#isactive-method
        Result := SubscriptionMgt.IsActive(
            GetSecret('StripeSecretKey'),
            GetSecret('StripeProductID'));
        if not Result then
            // https://docs.365extensions.com/docs/SM/docs/References/SubscriptionMgt#shownotification-method
            SubscriptionMgt.ShowNotification(
                GetSecret('StripeSecretKey'),
                GetSecret('StripeProductID'));
    end;

    [NonDebuggable]
    internal procedure IsTrialing(): Boolean
    begin
        // https://docs.365extensions.com/docs/SM/docs/References/SubscriptionMgt#istrialing-method
        exit(SubscriptionMgt.IsTrialing(
            GetSecret('StripeSecretKey'),
            GetSecret('SecondStripeProductID')))
    end;

    [NonDebuggable]
    local procedure GetSecret(Name: Text) Result: Text
    var
        SecretProvider: Codeunit DeveloperSecretProvider;
        // TODO: Should replaced with your own secret provider
        // SecretProvider: Codeunit "App Key Vault Secret Provider";
        GetSecretErr: Label 'Failed to get ''%1'' secret.', Comment = '%1 - Secret Name';
    begin
        if SecretProvider.TryInitializeFromCurrentApp() then
            if SecretProvider.GetSecret(Name, Result) then
                exit;
        LogError('SubscriptionMgtProxy-0001', GetSecretErr)
    end;

    local procedure LogError(EventId: Text; Message: Text)
    var
        CustDimension: Dictionary of [Text, Text];
    begin
        // TODO: Should be replaced with your telemetry signal. Can be replaced with Error if installation error is acceptable.
        /*
        LogMessage(
            EventId,
            Message,
            Verbosity::Critical,
            DataClassification::EndUserPseudonymousIdentifiers,
            TelemetryScope::ExtensionPublisher,
            CustDimension)
        */
    end;
}