<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.Locale"%>

<%

double value = 0;
double juros = 0;
double juros2= 0;
double juros3 = 0;
int months = 0;
double poten1 = 0;
double poten2 = 0;
double parcela = 0;
double parcela2 = 0;
double debtor = 0;
NumberFormat dinheiro = NumberFormat.getCurrencyInstance(new Locale("pt", "BR"));
int i = 1;

if(request.getParameter("valor") != null) {
value = Double.parseDouble(request.getParameter("valor"));
juros = Double.parseDouble(request.getParameter("juros"));
months = Integer.parseInt(request.getParameter("meses"));
juros2 = juros / 100;
poten1 = Math.pow((1 + juros2), months) * juros2;
poten2 = Math.pow((1 + juros2), months) - 1;
parcela = value * (poten1 / poten2);
debtor = (value - parcela);
juros3 = value * juros2;
parcela2 = value - debtor;
}

%>

<html>
<head>
<title>Calculadora Price</title>

</head>
<body>

	<%@include file="WEB-INF/Components/header.jspf"%>
	<%@include file="WEB-INF/Components/tabela.jspf"%>
	<h4>
		Valor a financiar:
		<%=(dinheiro.format(value))%></h4>
	<h4>
		Taxa de juros:
		<%=juros%>%
	</h4>
	<h4>
		meses:
		<%=months%></h4>
	<br>
	<br>

	<table class="table">
		<thead class="thead-dark">
			<tr>
				<th scope="col">Período</th>
				<th scope="col">Saldo Devedor</th>
				<th scope="col">Parcela</th>
				<th scope="col">Juros</th>
				<th scope="col">Amortização</th>
			</tr>
		</thead>

		<tbody>
			<tr>
				<th scope="row">0</th>
				<td><%=(dinheiro.format(value))%></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr>

				<%
				do {
				%>
				<%
				value = (value + juros3) - parcela2;
				%>
				<th scope="row"><%=i%></th>
				<%--PERIODO --%>
				<td><%=(dinheiro.format(value))%></td>
				<%-- SALDO DEVEDOR --%>
				<td><%=(dinheiro.format(parcela2))%></td>
				<%--PARCELA --%>
				<td><%=(dinheiro.format(juros3))%></td>
				<%-- JUROS --%>
				<td><%=(dinheiro.format(parcela2 - juros3))%></td>
				<%-- AMORTIZACAO --%>
				<%
				juros3 = value * juros2;
				%>

			</tr>

			<%
			debtor = value;
			%>
			<%
			debtor = value - parcela;
			%>
			<%
			i++;
			%>
			<%
			} while (i <= months);
			%>
		</tbody>
	</table>
	<%@include file="WEB-INF/Components/footer.jspf"%>
</body>
</html>