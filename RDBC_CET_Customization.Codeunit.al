// CET-specific settings: CET uses Document Import only, with its own processing messages.
codeunit 85202 "RDBC_CET_Customization"
{
    // What CET may use. The base allows nothing by default.
    // Document Import: allowed. Journal Import: not allowed (no subscriber for OnAllowJournalUpload).
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"RDBC_Base_Events", 'OnAllowDocumentUpload', '', false, false)]
    local procedure AllowDocumentUpload(var Allow: Boolean)
    begin
        Allow := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"RDBC_Base_Events", 'OnGetDocumentProgressMessages', '', false, false)]
    local procedure GetDocumentProgressMessages(var Messages: List of [Text]; var IsHandled: Boolean)
    begin
        AddCETMessages(Messages);
        IsHandled := true;
    end;

    // Customize these texts to CET's preferred processing messages.
    local procedure AddCETMessages(var Messages: List of [Text])
    begin
        Messages.Add('Calibrating sensors.');
        Messages.Add('Checking inventory.');
        Messages.Add('Building paperwork.');
        Messages.Add('Purging whitespace.');
        Messages.Add('Sensors warming up.');
        Messages.Add('Packing documents.');
        Messages.Add('Detecting lines.');
        Messages.Add('Counting ppm.');
        Messages.Add('Adding polish.');
        Messages.Add('Boosting sensitivity.');
        Messages.Add('Running bump tests.');
        Messages.Add('Zeroing readings.');
        Messages.Add('Sampling data.');
        Messages.Add('Rolling totals.');
        Messages.Add('Preparing paperwork.');
        Messages.Add('Factory certified.');
        Messages.Add('Syncing serials.');
        Messages.Add('Loading test gas.');
        Messages.Add('Verifying thresholds.');
        Messages.Add('Almost calibrated.');
        Messages.Add('Clearing alarms.');
        Messages.Add('Testing and exporting.');
        Messages.Add('Optimizing yield...');
        Messages.Add('Detecting insights...');
        Messages.Add('Processing efficiently...');
        Messages.Add('Aligning compliance...');
        Messages.Add('Preparing reports...');
        Messages.Add('Refining readings...');
        Messages.Add('Finalizing analytics...');
        Messages.Add('Assembling paperwork...');
        Messages.Add('Calculating faster...');
    end;
}
