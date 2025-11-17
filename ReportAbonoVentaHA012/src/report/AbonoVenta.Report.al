report 50100 AbonoVenta
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'src/report/AbonoVenta.rdl';

    Permissions = tabledata "Company Information" = r,
                  tabledata Customer = r,
                  tabledata "Sales Cr.Memo Header" = r,
                  tabledata "Sales Cr.Memo Line" = r,
                  tabledata "VAT Amount Line" = r,
                  tabledata "VAT Product Posting Group" = r,
                  tabledata "Cust. Ledger Entry" = r,
                  tabledata "Payment Terms" = r,
                  tabledata "Payment Method" = r;

    dataset
    {
        //HEADER ------------------------------------------------------------------------------------------------------------------------------------------
        dataitem(DataSet_Result; "Sales Cr.Memo Header")
        {

            column(Name; CompanyInformation.Name)
            {
                IncludeCaption = true;
            }
            column(CIF; CompanyInformation."VAT Registration No.")//  todo falta por ver como poner el "-" entre la B y el numero
            {
            }
            column(NameCustomer; "Bill-to Name") { }
            column(Bill_to_Address; "Bill-to Address") { }
            column(Bill_to_Post_Code; "Bill-to Post Code") { }
            column(Bill_to_City; "Bill-to City") { }
            column(Bill_to_County; "Bill-to County") { }
            column(No_; "No.") { }
            column(Posting_Date; "Posting Date") { }//  todo mostrar la fecha diferente




            dataitem(SalesLine; "Sales Cr.Memo Line")
            {
                // BODY ------------------------------------------------------------------------------------------------------------------------------------------
                DataItemLink = "Document No." = field("No.");

                //column(Picture; CompanyInformation.Picture) { }


            }

            dataitem(CustLedgerEntry; "Cust. Ledger Entry")
            {
                DataItemLink = "Document No." = field("No.");
                //column(DueDate; "Due Date") { }
            }
        }
    }



    labels
    {
        CIFlbl = 'C.I.F.'; //  todo falta por ver como poner el "-" entre la B y el numero
        FacturaNolbl = 'Factura Nº:';
        FechaFacturalbl = 'Fecha Factura:';
        NIFlbl = 'N.I.F.:';
        FechaEntregalbl = 'Fecha de Entrega:';
    }

    trigger OnPreReport()
    begin
        CompanyInformation.Get();

    end;

    var
        CompanyInformation: Record "Company Information";
}