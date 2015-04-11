<%@ page import="com.liferay.portal.kernel.util.ParamUtil" %>
<%@ page import="im.ligas.ImprovedDemoMVCPortlet" %>
<%@ page import="im.ligas.FormDto" %>

<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ taglib prefix="aui" uri="http://alloy.liferay.com/tld/aui" %>

<portlet:defineObjects/>

<portlet:renderURL var="redirect"/>

<h4>This portlet demonstrates features of the Improved Liferay MVCPortlet</h4>

<h5>Values served by controller for clean controller view separation.</h5>
<b>"${defaultValue}"</b>
<b>"${defaultObject}"</b>

<hr/>

<h5>Switch to a different view.</h5>
<portlet:renderURL var="url">
	<portlet:param name="mvcPath" value="/view2.jsp"/>
	<portlet:param name="setModel" value="customSetModel"/>
</portlet:renderURL>
<a href="${url}">link</a>

<hr/>

<h5>Example of form processing.</h5>
Default form value: ${defaultObject}<br/>
Preserved value from form: <%= ParamUtil.getString(request, "formValue")%><br/>

<portlet:actionURL name="handleForm" var="formURL">
	<portlet:param name="redirect" value="${redirect}"/>
</portlet:actionURL>

<aui:model-context bean="${defaultObject}" model="<%=FormDto.class%>"/>

<aui:form action="${formURL}" name="fm" method="POST">
	<aui:input name="formValue" type="text" lable="Value" helpMessage="Form will accept value higher then 100."/>
	<aui:button type="submit"/>
</aui:form>

<hr/>

<h5>Example of resource serving from a JSP file with values populated form controller.</h5>
<portlet:resourceURL id="serveResourceJSP" var="resourceURL1">
	<portlet:param name="mvcPath" value="/json.jsp"/>
</portlet:resourceURL>
<a href="javascript:void(0)" class="resource-call-1">resource 1</a>

<br/>

<h5>Example of resource serving from the controller custom method - customResourceMethod.</h5>
<portlet:resourceURL id="customResourceMethod" var="resourceURL2" />
<a href="javascript:void(0)" class="resource-call-2">resource 2</a>

<aui:script use="aui-io-request">
	function _ioCall(url){
		A.io.request(url,	{
			on: {
				success: function () {
					var data = this.get('responseData');
						alert(data);
					}
				}
			}
		);
	}

	A.one(".resource-call-1").on('click',function(){_ioCall('${resourceURL1}')});
	A.one(".resource-call-2").on('click',function(){_ioCall('${resourceURL2}')});
</aui:script>