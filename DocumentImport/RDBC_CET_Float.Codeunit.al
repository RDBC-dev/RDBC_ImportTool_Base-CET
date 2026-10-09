// Document Import Type "Float": a Purchase Invoice whose tax setup always comes from the vendor.
// Validation, creation and result message reuse the base Purchase Invoice logic.
codeunit 85200 "RDBC_CET_Float"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"RDBC_Base_Events", 'OnValidateCustomDocumentType', '', false, false)]
    local procedure ValidateFloat(var Staging: Record "RDBC_Base_DocImp_Staging"; var ErrorText: Text[1024]; var IsHandled: Boolean)
    var
        ValidationMgt: Codeunit "RDBC_Base_DocImpValidationMgt";
    begin
        if Staging."Document Import Type" <> Staging."Document Import Type"::"Float" then
            exit;

        ApplyVendorTaxDefaults(Staging);
        ValidationMgt.ValidateLineAs(Staging."Document Import Type"::"PI", Staging, ErrorText);
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"RDBC_Base_Events", 'OnProcessCustomDocumentType', '', false, false)]
    local procedure ProcessFloat(var GroupRec: Record "RDBC_Base_DocImp_Staging"; var Staging: Record "RDBC_Base_DocImp_Staging"; var DocumentNo: Code[20]; var Success: Boolean; var IsHandled: Boolean)
    var
        PIProcessor: Codeunit "RDBC_Base_PI_Processor";
    begin
        if Staging."Document Import Type" <> Staging."Document Import Type"::"Float" then
            exit;

        Success := PIProcessor.Process(GroupRec, Staging, DocumentNo);
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"RDBC_Base_Events", 'OnShowProcessingResultCustomDocumentType', '', false, false)]
    local procedure ShowFloatResult(DocumentImportType: Enum "RDBC_Base_DocImpType"; DataImportName: Text[50])
    var
        PIProcessor: Codeunit "RDBC_Base_PI_Processor";
    begin
        if DocumentImportType <> DocumentImportType::"Float" then
            exit;

        PIProcessor.ShowProcessingResultForPI(DataImportName);
    end;

    // "NO TAX" coming in from the import means: take Tax Liable and Tax Area Code from
    // the Vendor, and force the line onto the non-taxable Tax Group.
    local procedure ApplyVendorTaxDefaults(var Staging: Record "RDBC_Base_DocImp_Staging")
    var
        Vendor: Record Vendor;
    begin
        if Staging."Tax Area Code" = 'NO TAX' then
            Staging."Tax Group Code" := 'NONTAXABLE';

        Staging."Tax Liable" := false;
        Staging."Tax Area Code" := '';
        if Vendor.Get(Staging."Business Relation No.") then begin
            Staging."Tax Liable" := Vendor."Tax Liable";
            Staging."Tax Area Code" := Vendor."Tax Area Code";
        end;
    end;
}
