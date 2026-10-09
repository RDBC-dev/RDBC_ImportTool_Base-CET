# RDBC - ImportTool - CET

CET-specific extension of the RDBC Import Tool. Requires **RDBC - ImportTool - Base**
(repository RDBC_ImportTool_Base) to be installed first.

Object ID range: 85200–85299.

| What | Where |
|---|---|
| Document Import Type **Float** (Purchase Invoice with vendor tax defaults; `NO TAX` → Tax Group `NONTAXABLE`) | `DocumentImport/` |
| **Journal Import switched off** (Allow Journal Upload = false: no tiles, pages or processing) | `RDBC_CET_Customization.Codeunit.al` |
| CET processing messages | `RDBC_CET_Customization.Codeunit.al` |

All CET logic plugs into the base through the events in `RDBC_Base_Events`; no base code is copied.
