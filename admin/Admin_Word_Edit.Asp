<!--#include file="Const.Asp"-->
<!--#include file="../PL_INC/Cls_ShowoPage.asp"-->
<%CheckAdmin1%>
<!--#include file="Top.Asp"-->
<LINK href="admin.css" type=text/css rel=stylesheet>
<%
'
'����������������������������������������������������
'��                                                                   ��
'��                     Ʒ�����ֳ���ϵͳ1.0                              ��
'��                                                                   ��
'��     �ռ�����: Ʒ��  www.pinluo.com                                  ��
'��                                                                   ��
'��     ��������: ����  www.caozha.com                                  ��
'��                                                                   ��
'��     Դ�����Apache-2.0��ѿ�Դ���뱣�����������ӣ�                      ��
'��                                                                   ��
'����������������������������������������������������
'
'
	Dim MusicID,SinGer,MusicName,SpecialName,Words,Flag,AddUser
	Set Rs = Server.Createobject("adodb.recordset")
	Sql="Select * from TextWord Where id="&request("id") 
	Rs.Open Sql,Conn,1,1
	If Not Rs.EOF Then
		MusicID 	= Rs("MusicID")
		SinGer 		= Rs("SinGer")
		MusicName	= Rs("MusicName")
		SpecialName	= Rs("SpecialName")
		Words		= Rs("Words")
		Flag		= Rs("Flag")
		AddUser		= Rs("AddUser")
	Else
		errmsg=errmsg+"<li>�˹�����ʱ������</li>"
		call error()
		Response.End	
	End if
	Rs.Close
	Set Rs = Nothing
%>
<body topmargin="111" leftmargin="0">
<div align=center>
<form name="WordsForm" action="Admin_Word_Err.Asp?id=<%=Request("id")%>"  method="POST">
 <input type="hidden" name="TempID" value="0">
 <table class="tableBorder" width="100%" border="0" align="center" cellpadding="2" cellspacing="1" >
	<tr class="title">
          <td height=20 align=center Class="title" colspan=2><strong>�ı���ʱ༭</strong></td>
          </tr>
	<tr>
	  <td width="10%" height=22 class="forumrow" align=center><strong>��������</strong></td>
	  <td height=22 class="forumrow"><b><%=SinGer%></b></td>
	</tr>
	<tr>
	  <td width="10%" height=22 class="forumrow" align=center><strong>��������</strong></td>
	  <td height=22 class="forumrow"><b><%=MusicName%></b></td>
	</tr>
	<tr>
	  <td width="10%" height=22 class="forumrow" align=center><strong>����ר��</strong></td>
	  <td height=22 class="forumrow"><b><%=SpecialName%></b></td>
	</tr>
	<tr>
	  <td width="10%" height=22 class="forumrow" align=center><strong>�������</strong></td>
	  <td height=22 class="forumrow">
		<TEXTAREA name="Words" rows=10 cols=60"><%=htmlencode1(Words)%></TEXTAREA>
	  </td>
	</tr>
	<tr>
	  <td width="10%" height=22 class="forumrow" align=center><strong>�������</strong></td>
	  <td height=22 class="forumrow"><input type="checkbox" name="Flag" value="1" <%If Flag=True Then:Response.Write "Checked":End If%>></td>
	</tr>
	<tr>
	  <td width="10%" height=22 class="forumrow" align=center><strong>���������</strong></td>
	  <td height=22 class="forumrow"><input type="text" name="AddUser" value="<%=AddUser%>"></td>
	</tr>
	<tr>
          <td height=20 align=center class="forumrow" colspan=2>
		<input type=submit name=submit value="�� ��"> <input type=reset name=reset value="�� ��">
	  </td>
          </tr>
	<tr>

  </table>
</form>

<script language="javascript">
	function DisWords(TempID,Words,AddUser)
	{
		WordsForm.TempID.value  = TempID;
		WordsForm.Words.value 	= Words;
		WordsForm.AddUser.value = AddUser;
	}
</script>

<table class="tableBorder" width="100%" border="0" align="center" cellpadding="2" cellspacing="1" >
	<tr class="title">
          <td width="20%" height="22" align="center"><strong>��������</strong></td>
          <td width="25%" height="22" align="center"><strong>��������</strong></td>
          <td width="25%" height="22" align="center"><strong>����ר��</strong></td>
          <td width="10%" height="22" align="center"><strong>������</strong></td>
          <td width="5%" height="22" align="center"><strong>���</strong></td>
          <td width="5%" height="22" align="center"><strong>��Ʊ</strong></td>
          <td width="10%" height="22" align="center">ѡ��</td>
	</tr>
<%
	Dim WhereStr
	WhereStr = "WordType='TextWord' And MusicID=" & MusicID
	Dim ors
	Set ors = New Cls_ShowoPage	'��������
	With ors
		.Conn 		= Conn			'�õ����ݿ����Ӷ���
		.DbType		= "AC"
		'���ݿ�����,ACΪaccess,MSSQLΪsqlserver2000,MSSQL_SPΪ�洢���̰�,MYSQLΪmysql,PGSQLΪPostGreSql	
		.RecType	= 0
		'ȡ��¼��������(0ִ��count,1��дsql���ȡ,2�̶�ֵ)
		.RecSql		= 0
		'���RecType��1��=ȡ��¼sql��䣬�����2=��ֵ������0=""
		.RecTerm	= 2	
		'ȡ�Ӽ�¼�����Ƿ��б仯(0�ޱ仯,1�б仯,2������cookiesҲ���Ǽ�ʱͳ�ƣ�����������ʱ��)
		.CookieName	= "a306_TempWords"	'���RecTerm��2,cookiesname="",����дcookiesname
		.Order		= 0			'����(0˳��1����),ע��Ҫ������sql��������ID�������Ӧ
		.PageSize	= 20		'ÿҳ��¼����
		.JsUrl		= "../PL_INC/"			'showo_page.js��·��
		.Sql		= "*$TempWord$"&WhereStr&"$Poll$ID" '�ֶ�,��,����(����Ҫwhere),����(����Ҫ��ҪORDER BY),����ID
	End With

	iRecCount = Ors.RecCount()'��¼����
	iRs = Ors.ResultSet()		'����ResultSet
	If  iRecCount<1 Then

%>
	<tr>
	  <td colspan=7 align=center>û���ҵ��κμ�¼!</td>
   	</tr>
<%
	Else
		For i=0 To Ubound(iRs,2)
			tWords   = iRs(6,i)
			tWords   = Replace(tWords,Chr(34),"")
			tWords   = Replace(tWords,vbCrLf,"<br>\n")
			tWords   = Replace(tWords,"(","")
			tWords   = Replace(tWords,")","")
			tWords   = Replace(tWords,"'","\'")

			tAddUser = iRs(7,i)
			tAddUser = Replace(tAddUser,Chr(34),"")
			tAddUser = Replace(tAddUser,vbCrLf,"<br>\n")
			tAddUser = Replace(tAddUser,"'","\'")

%>
        <tr title="<%=Replace(iRs(6,i),Chr(34),"")%>">
          <td class="forumrow" height=22 align=center><%=iRs(3,i)%></td>
          <td class="forumrow" height=22 align=center><font color=blue><%=iRs(4,i)%></font></td>
          <td class="forumrow" height=22 align=center><%=iRs(5,i)%></td>
          <td class="forumrow" height=22 align=center><%=iRs(7,i)%></td>
          <td class="forumrow" height=22 align=center><%=iRs(10,i)%></td>
          <td class="forumrow" height=22 align=center><%=iRs(11,i)%></td>
          <td class="forumrow" height=22 align=center><input type="radio" name="distext" value="<%=iRs(0,i)%>" onClick="DisWords('<%=iRs(0,i)%>','<%=tWords%>','<%=tAddUser%>')"></td> 
   	</tr>


<%
		Next	
	End If
%>
	</table>
	<table class="tableBorder" width="100%" border="0" cellspacing="2" cellpadding="2" align="center">
  		<tr> 
    			<td><%Ors.ShowPage()%></td>
  		</tr>  
	</table> 

<%
	iRs=NULL
	ors=NULL
	Set ors=Nothing
	Conn.Close
	Set Conn = Nothing
%>
</table>