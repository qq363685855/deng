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
	Sql="Select * from LrcWord Where Musicid="&request("id") 
	Rs.Open Sql,Conn,1,1
	If Not Rs.EOF Then
		MusicID 	= Rs("MusicID")
		SinGer 		= Rs("SinGer")
		MusicName	= Rs("MusicName")
		SpecialName	= Rs("SpecialName")
		Words		= Rs("Words")
		Flag		= Rs("Flag")
		AddUser		= Rs("AddUser")

%>
<body topmargin="111" leftmargin="0">
<div align=center>
<form name="WordsForm" action="Admin_LrcWord_Err1.Asp?id=<%=Request("id")%>"  method="POST">
 <input type="hidden" name="TempID" value="0">
 <table class="tableBorder" width="100%" border="0" align="center" cellpadding="2" cellspacing="1" >
	<tr class="title">
          <td height=20 colspan=2 align=center background="images/manage/admin_bg_1.gif" Class="title"><strong>LRC��ʱ༭</strong></td>
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

<%

	Rs.Close
	Set Rs = Nothing
%>


<%
	Else
Set Rs = Server.Createobject("adodb.recordset")
	Sql="Select * from MusicList Where id="&request("id") 
	Rs.Open Sql,Conn,1,1
        If Not Rs.EOF Then
%>
<form name="WordsForm" action="Admin_LrcWord_Err.Asp?id=<%=Request("id")%>"  method="POST">
 <input type="hidden" name="TempID" value="0">
 <table class="tableBorder" width="100%" border="0" align="center" cellpadding="2" cellspacing="1" >
	<tr class="title">
          <td height=20 align=center Class="title" colspan=2><strong>LRC��ʱ༭</strong></td>
          </tr>
        <tr>
	  <td width="10%" height=22 class="forumrow" align=center><strong>��������</strong></td>
	  <td height=22 class="forumrow"><input type="text" name="MusicName" value="<%=rs("MusicName")%>" size="50"></td>
	</tr>
          <tr>
	  <td width="10%" height=22 class="forumrow" align=center><strong>��������</strong></td>
	  <td height=22 class="forumrow"><input type="text" name="SinGer" value="<%=rs("SinGer")%>" size="50"></td>
	</tr>
	<tr>
	  <td width="10%" height=22 class="forumrow" align=center><strong>�������</strong></td>
	  <td height=22 class="forumrow">
		<TEXTAREA name="Words" rows=10 cols=60"></TEXTAREA>
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
<%
	End if
        End if

	Conn.Close
	Set Conn = Nothing
%>
