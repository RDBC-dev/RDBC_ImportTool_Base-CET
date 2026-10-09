// Additional Dimensions on journal import: Excel/CSV columns 21-23 are read into
// CUSTOMERGROUP, VENDORGROUP and PARENTCOMPANY, validated and posted on the journal line.
codeunit 85201 "RDBC_CET_AdditionalDims"
{
    var
        CustomerGroupDimTok: Label 'CUSTOMERGROUP', Locked = true;
        VendorGroupDimTok: Label 'VENDORGROUP', Locked = true;
        ParentCompanyDimTok: Label 'PARENTCOMPANY', Locked = true;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"RDBC_Base_Events", 'OnAfterReadJournalExcelRow', '', false, false)]
    local procedure ReadExcelColumns(var Staging: Record "RDBC_Base_JnlImp_Staging"; var ExcelBuffer: Record "Excel Buffer" temporary; RowNo: Integer)
    begin
        Staging."RDBC_CET_Additional Dim. 1" := CopyStr(GetCellValue(ExcelBuffer, RowNo, 21), 1, MaxStrLen(Staging."RDBC_CET_Additional Dim. 1"));
        Staging."RDBC_CET_Additional Dim. 2" := CopyStr(GetCellValue(ExcelBuffer, RowNo, 22), 1, MaxStrLen(Staging."RDBC_CET_Additional Dim. 2"));
        Staging."RDBC_CET_Additional Dim. 3" := CopyStr(GetCellValue(ExcelBuffer, RowNo, 23), 1, MaxStrLen(Staging."RDBC_CET_Additional Dim. 3"));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"RDBC_Base_Events", 'OnAfterReadJournalCsvRow', '', false, false)]
    local procedure ReadCsvColumns(var Staging: Record "RDBC_Base_JnlImp_Staging"; Columns: List of [Text])
    begin
        Staging."RDBC_CET_Additional Dim. 1" := CopyStr(GetColumnValue(Columns, 21), 1, MaxStrLen(Staging."RDBC_CET_Additional Dim. 1"));
        Staging."RDBC_CET_Additional Dim. 2" := CopyStr(GetColumnValue(Columns, 22), 1, MaxStrLen(Staging."RDBC_CET_Additional Dim. 2"));
        Staging."RDBC_CET_Additional Dim. 3" := CopyStr(GetColumnValue(Columns, 23), 1, MaxStrLen(Staging."RDBC_CET_Additional Dim. 3"));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"RDBC_Base_Events", 'OnAfterValidateJournalLine', '', false, false)]
    local procedure ValidateAdditionalDimensions(var Staging: Record "RDBC_Base_JnlImp_Staging"; var ErrorText: Text[1024])
    var
        ImportHelper: Codeunit "RDBC_Base_ImportHelper";
    begin
        ImportHelper.ValidateDimensionValue(CustomerGroupDimTok, Staging."RDBC_CET_Additional Dim. 1", ErrorText);
        ImportHelper.ValidateDimensionValue(VendorGroupDimTok, Staging."RDBC_CET_Additional Dim. 2", ErrorText);
        ImportHelper.ValidateDimensionValue(ParentCompanyDimTok, Staging."RDBC_CET_Additional Dim. 3", ErrorText);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"RDBC_Base_Events", 'OnAddJournalDimensions', '', false, false)]
    local procedure AddAdditionalDimensions(GroupRec: Record "RDBC_Base_JnlImp_Staging"; var TempDimSetEntry: Record "Dimension Set Entry" temporary; var HasDimensions: Boolean)
    var
        ImportHelper: Codeunit "RDBC_Base_ImportHelper";
    begin
        if (GroupRec."RDBC_CET_Additional Dim. 1" = '') and
           (GroupRec."RDBC_CET_Additional Dim. 2" = '') and
           (GroupRec."RDBC_CET_Additional Dim. 3" = '')
        then
            exit;

        ImportHelper.SetDimension(TempDimSetEntry, CustomerGroupDimTok, GroupRec."RDBC_CET_Additional Dim. 1");
        ImportHelper.SetDimension(TempDimSetEntry, VendorGroupDimTok, GroupRec."RDBC_CET_Additional Dim. 2");
        ImportHelper.SetDimension(TempDimSetEntry, ParentCompanyDimTok, GroupRec."RDBC_CET_Additional Dim. 3");
        HasDimensions := true;
    end;

    local procedure GetCellValue(var ExcelBuffer: Record "Excel Buffer" temporary; RowNo: Integer; ColumnNo: Integer): Text
    begin
        if ExcelBuffer.Get(RowNo, ColumnNo) then
            exit(ExcelBuffer."Cell Value as Text");

        exit('');
    end;

    local procedure GetColumnValue(Columns: List of [Text]; ColumnNo: Integer): Text
    begin
        if ColumnNo <= Columns.Count then
            exit(Columns.Get(ColumnNo));

        exit('');
    end;
}
