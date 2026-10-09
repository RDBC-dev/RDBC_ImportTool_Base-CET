tableextension 85200 "RDBC_CET_JnlImpStaging" extends "RDBC_Base_JnlImp_Staging"
{
    fields
    {
        field(85200; "RDBC_CET_Additional Dim. 1"; Code[20]) { DataClassification = CustomerContent; Caption = 'CUSTOMERGROUP'; }
        field(85201; "RDBC_CET_Additional Dim. 2"; Code[20]) { DataClassification = CustomerContent; Caption = 'VENDORGROUP'; }
        field(85202; "RDBC_CET_Additional Dim. 3"; Code[20]) { DataClassification = CustomerContent; Caption = 'PARENTCOMPANY'; }
    }
}
