pageextension 85200 "RDBC_CET_JnlImpStaging" extends "RDBC_Base_JnlImp_Staging"
{
    layout
    {
        addafter("Shortcut Dimension 8")
        {
            field("RDBC_CET_Additional Dim. 1"; Rec."RDBC_CET_Additional Dim. 1") { ApplicationArea = All; Editable = IsEditable; } // CUSTOMERGROUP DIMENSION
            field("RDBC_CET_Additional Dim. 2"; Rec."RDBC_CET_Additional Dim. 2") { ApplicationArea = All; Editable = IsEditable; } // VENDORGROUP DIMENSION
            field("RDBC_CET_Additional Dim. 3"; Rec."RDBC_CET_Additional Dim. 3") { ApplicationArea = All; Editable = IsEditable; } // PARENTCOMPANY DIMENSION
        }
    }
}
