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
            column(NIF; "VAT Registration No.") { }
            column(Due_Date; "Due Date") { }




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
        InvoiceNolbl = 'Invoice Nº:';
        InvoiceDatelbl = 'Invoice Date:';
        NIFlbl = 'N.I.F.:';
        DeliveryDatelbl = 'Delivery Date:';
        Conceptlbl = 'Concept';
        Amount = 'Amount';
        InformationClause = 'Information Clause';
        LawText = 'Con el siguiente texto fijo: “De conformidad con el artículo 13 de la sección 2 del Reglamento (UE) 2016/679 del Parlamento Europeo y del Consejo, de 27 de abril de 2016 y la Ley Orgánica 3/2018, relativo a la protección de las personas físicas en lo que respecta al tratamiento de datos personales y a la libre circulación de estos datos, le informamos que el responsable del tratamiento es CLÍNICA LA ARRUZAFA, S.L., que dicho tratamiento se lleva a cabo para la gestión contable, fiscal y administrativa y para el envio de comunicaciones comerciales sobre productos y servicios de la Clínica que ser de su interés. La base legal que permite legitimar este tratamiento el cumplimiento de una obligación legal. Se comunicarán datos a terceros para poder llevar a cabo las finalidades objeto de este contrato. Puede usted acceder, rectificar y suprimir sus datos, así como otros derechos, dirigiéndose por escrito a nuestro Delegado de Protección de Datos m.montaldo@compliancecorporativo.es. Puede usted obtener información ampliada sobre protección de datos solicitándola a nuestro Delegado de Protección de Datos m.montaldo@compliancecorporativo.es”.';
        ToTalInvoice = 'Total Invoice EUR:';
    }

    trigger OnPreReport()
    begin
        CompanyInformation.Get();

    end;

    var
        CompanyInformation: Record "Company Information";
}