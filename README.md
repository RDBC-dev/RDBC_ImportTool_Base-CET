# RDBC - ImportTool - CET

CET-specific extension of the RDBC Import Tool. Requires **RDBC - ImportTool - Base**
(repository RDBC_ImportTool_Base) to be installed first.

Object ID range: 85200–85299.

| What | Where |
|---|---|
| Document Import Type **Float** (Purchase Invoice with vendor tax defaults; `NO TAX` → Tax Group `NONTAXABLE`) | `DocumentImport/` |
| **Additional Dimensions** CUSTOMERGROUP, VENDORGROUP, PARENTCOMPANY on journal import (Excel/CSV columns 21–23) | `JournalImport/` |
| CET processing messages (Document and Journal Upload both allowed) | `RDBC_CET_Customization.Codeunit.al` |

All CET logic plugs into the base through the events in `RDBC_Base_Events`; no base code is copied.
