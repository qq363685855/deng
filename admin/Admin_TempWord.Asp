<!--#include file="const.asp"-->
<!--#include file="../PL_INC/Cls_ShowoPage.asp"-->
<!--#include file="../PL_INC/Function.asp"-->
<%CheckAdmin1%>
<%PageName="songwordsadmin"%>
<!--#include file="Top.Asp"-->
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
Dim Act,ID,listtype

Act 	 = Request("Act")
ID 	 = CheckRequest("ID")
listtype = CheckRequest("listtype")

Select Case Act
	Case "Delete"
	Call SetArticle("Delete",ID,1)
	Case "SetCheckedYes"
	Call SetArticle("SetCheckedYes",ID,1)
	Case "SetCheckedNo"
	Call SetArticle("SetCheckedNo",ID,1)
	Case Else
	Call Main()
End Select

Conn.Close
Set Conn = Nothing


'����ö�����
Sub SetArticle(MyAct,MyID,MsgShow)
	If IsSelfRefer = False Then
		Msg_TempStr = Msg_TempStr & "<li>��ֹ�ӱ�վ�ⲿ�ύ����!</li><br>"
		Call Message("������ʾ��Ϣ!",Msg_TempStr,0,"")
		Exit Sub
	End If
	Dim strAct ,strWhere
	'���ֻ��һ��ID
	If InStr(MyID,",") > 0 Then
		strAct = "����"
	End If
	Set Rs = Server.Createobject("adodb.recordset")
	Sql = "Select * From TempWord Where ID In ("&MyID&")"
	Rs.Open Sql,Conn,1,3
	If Rs.Bof Or Rs.Eof Then
		Msg_TempStr = Msg_TempStr & "<li>û���ҵ���ظ��!</li><br>"
		Call Message("������ʾ��Ϣ!",Msg_TempStr,0,"")
	Else
		Select Case MyAct
			Case "Delete"
			strAct = strAct & "���ɾ���ɹ�!"
			Do While Not Rs.Eof
				Rs.Delete
				Rs.MoveNext
			Loop
			Msg_TempStr = Msg_TempStr & strAct & "<br>" & VbCrLf
			Case "SetCheckedYes"
			strAct = strAct & "�����˳ɹ�!"
			Do While Not Rs.Eof
				Rs("Checked") = True
				Rs.Update
				AddExp Rs("AddUser")
				Rs.MoveNext
			Loop
			Msg_TempStr = Msg_TempStr & strAct & "<br>" & VbCrLf
			Case "SetCheckedNo"
			strAct = strAct & "ȡ����˳ɹ�!"
			Do While Not Rs.Eof
				Rs("Checked") = False
				Rs.Update
				Rs.MoveNext
			Loop
			Msg_TempStr = Msg_TempStr & strAct & "<br>" & VbCrLf
		End Select

		If MsgShow = 1 Then
			Call Message(strAct,Msg_TempStr,3000,CacheUrl("TempWordUrl",1))
		Else
			Response.Redirect CacheUrl("TempWordUrl",1)
		End If
	End If
	Rs.Close
	Set Rs = Nothing
End Sub

Sub AddExp(UserName)
	Conn.Execute("Update [User] Set ExpWord=ExpWord+5 Where UserName='"&UserName&"'") 'ͨ����˹���ӵ����5��
End Sub

Sub Main()
Call CacheUrl("TempWordUrl",0)
%>
<LINK href="admin.css" type=text/css rel=stylesheet>

<table class="tableBorder" width="100%" height="30" border="0" cellpadding="0" cellspacing="0"   align="center" style="margin-top:10px;">
  <tr>
    <td width="20%">&nbsp;</td>
    <td width="20%"><img src="../Images/Dont06.gif" width="8" height="8"> <a href="?">��ʾ���и��</a></td>
    <td width="20%" align="center"><img src="../Images/Dont06.gif" width="8" height="8"> <a href="?listtype=1">��ʾ��˹��ĸ��</a></td>
    <td width="20%"align="center"><img src="../Images/Dont06.gif" width="8" height="8"> <a href="?listtype=2">��ʾδ��˸��</a></td>
	<td width="20%"</td>
  </tr>
</table>
<script language='javascript'>
function unselectall()
{
	try {
    		if(document.myform.chkAll.checked)
		{
 			document.myform.chkAll.checked = document.myform.chkAll.checked&0;
    		}
	}
	catch(e){
		//alert(e.description);
		alert("û���κβ�������!");
		return false;
	}
}

function SelectAll() 
{
	try {
		for (var i=0;i<document.myform.ID.length;i++) 
		{
			var e=document.myform.ID[i];
			e.checked=!e.checked;
		}
	}
	catch(e){
		//alert(e.description);
		alert("û���κβ�������!");
		return false;
	}
}

//ȡѡ������
function CheckedNum()
{
	var sNum = 0;
	if(isNaN(document.myform.ID.length)&&document.myform.ID.checked)
	{
		sNum++;
	}else{
		for (var i=0;i<document.myform.ID.length;i++) 
		{
			if (document.myform.ID[i].checked)
			{
				sNum++;
			}
		}
	}
	return sNum;
}


//������
function CheckForm()
{
	var Act = document.myform.Act.value;
	try {
		var ChkNum = CheckedNum();
	}
	catch(e){
		//alert(e.description);
		alert("û���κβ�������!");
		return false;
	}
	switch(Act)
	{
		case "Delete":
		if (ChkNum<=0)
		{
			alert("����ѡ��һ�����!");
			return false;
		}
		else
		{
			if (confirm("��ȷ��ɾ�������"))
			{
				return true;
			}else
			{
				return false;
			}
		}
		break;
		//��˸��
		case "SetCheckedYes":
		if (ChkNum<=0)
		{
			alert("����ѡ��һ�����!");
			return false;
		}
		else
		{
			return true;
		}
		break;
		case "SetCheckedNo":
		if (ChkNum<=0)
		{
			alert("����ѡ��һ�����!");
			return false;
		}
		else
		{
			return true;
		}
		break;
		default:
		alert("��ѡ�����ѡ��!");
		return false;
	}
}
</script>
<form name='myform' onsubmit='return CheckForm()' method="POST" action='Admin_TempWord.Asp?listtype=<%=listtype%>'>
<input type='hidden' name='Act' id='Act'>

<table class="tableBorder" width="100%" border="0" align="center" cellpadding="2" cellspacing="1" >
	<tr class="title">
	  <td width="5%" height="22" align="center"><strong>ѡ��</strong></td>
          <td width="5%" height="22" align="center"><strong>����</strong></td>
          <td width="20%" height="22" align="center"><strong>��������</strong></td>
          <td width="20%" height="22" align="center"><strong>��������</strong></td>
          <td width="20%" height="22" align="center"><strong>����ר��</strong></td>
          <td width="10%" height="22" align="center"><strong>������</strong></td>
          <td width="5%" height="22" align="center"><strong>���</strong></td>
          <td width="5%" height="22" align="center"><strong>��Ʊ</strong></td>
          <td width="10%" height="22" align="center"><strong>��ʱ༭</strong></td>
	</tr>
<%
	Dim WhereStr

	If listtype<>""then
		If listtype=1 then
			WhereStr = "Checked=1" 
		Elseif listtype=2 then
			WhereStr = "Checked=0" 
		End if
	Else
		WhereStr = "" 
	End if

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
		.CookieName	= "a306"	'���RecTerm��2,cookiesname="",����дcookiesname
		.Order		= 0			'����(0˳��1����),ע��Ҫ������sql��������ID�������Ӧ
		.PageSize	= 20		'ÿҳ��¼����
		.JsUrl		= "../PL_INC/"			'showo_page.js��·��
		.Sql		= "*$TempWord$"&WhereStr&"$AddTime$ID" '�ֶ�,��,����(����Ҫwhere),����(����Ҫ��ҪORDER BY),����ID
	End With

	iRecCount = Ors.RecCount()'��¼����
	iRs = Ors.ResultSet()		'����ResultSet
	If  iRecCount<1 Then

%>
	<tr>
	  <td colspan=9 align=center>û���ҵ��κμ�¼!</td>
   	</tr>
<%
	Else
		For i=0 To Ubound(iRs,2)
			If iRs(1,i) = "TextWord" Then
				sType = "�ı�"
			Else
				sType = "LRC"
			End If
%>
        <tr>
	  <td class="forumrow" height=22 align=center><input type="checkbox" name="ID" value="<%=iRs(0,i)%>"></td>
          <td class="forumrow" height=22 align=center><%=sType%></td>
          <td class="forumrow" height=22 align=center><%=iRs(3,i)%></td>
          <td class="forumrow" height=22 align=center><font color=blue><%=iRs(4,i)%></font></td>
          <td class="forumrow" height=22 align=center><%=iRs(5,i)%></td>
          <td class="forumrow" height=22 align=center><%=iRs(7,i)%></td>
          <td class="forumrow" height=22 align=center><%=iRs(10,i)%></td>
          <td class="forumrow" height=22 align=center><%=iRs(11,i)%></td>
          <td class="forumrow" height=22 align=center><a href="<%If iRs(1,i) = "TextWord" Then:Response.Write "Admin_Word_Edit.Asp":Else:Response.Write "Admin_LrcWord_Edit.Asp":End If%>?id=<%=iRs(2,i)%>">��ʱ༭</a></td> 
   	</tr>


<%
		Next	
	End If
%>
	</table>
	<table class="tableBorder" width="100%" border="0" cellspacing="2" cellpadding="2" align="center">
		<tr>
			<col align='center' width='60'></col>
			<col align='Right'></col>
		</tr>
  		<tr> 
    			<td>
				<input name='chkAll' id='chkAll' type='checkbox' onclick='SelectAll()' value='checkbox'>&nbsp;ȫѡ
			</td>
			<td>
		
				<input type='submit' class='button' onClick="document.myform.Act.value='Delete'" value='ɾ��ѡ�����'>
				<input type='submit' class='button' onClick="document.myform.Act.value='SetCheckedYes'" value='�������'>
				<input type='submit' class='button' onClick="document.myform.Act.value='SetCheckedNo'" value='ȡ�����'>
			
			</td>
  		</tr> 
	</table> 
	</form>
	<table class="tableBorder" width="100%" border="0" cellspacing="2" cellpadding="2" align="center">
  		<tr> 
    			<td><%Ors.ShowPage()%></td>
  		</tr>  
	</table> 

<%
	iRs=NULL
	ors=NULL
	Set ors=Nothing
%>
</table>
<%
End Sub
%>
</body></html>