<%=packageName%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#edit-${domainClass.propertyName}" class="sr-only" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <ol class="breadcrumb">
            <li><a href="\${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
            <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
            <li class="active"><g:message code="default.edit.label" args="[entityName]" /></li>
        </ol>
		<div id="edit-${domainClass.propertyName}" role="main">
            <div class="page-header">
                <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            </div>
			<g:if test="\${flash.message}">
            <div class="alert alert-info alert-dismissable" role="status">\${flash.message}</div>
			</g:if>
			<g:hasErrors bean="\${${propertyName}}">
			<ul class="errors" role="alert">
				<g:eachError bean="\${${propertyName}}" var="error">
                <div class="alert alert-danger" <g:if test="\${error in org.springframework.validation.FieldError}">data-field-id="\${error.field}"</g:if>><g:message error="\${error}"/></div>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form class="form-horizontal" role="form" url="[resource:${propertyName}, action:'update']" method="PUT" <%= multiPart ? ' enctype="multipart/form-data"' : '' %>>
				<g:hiddenField name="version" value="\${${propertyName}?.version}" />
                <g:render template="form"/>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <g:actionSubmit class="save" action="update" value="\${message(code: 'default.button.update.label', default: 'Update')}" />
                        <g:link class="list" action="index"><g:message code="default.button.cancel.label"/> </g:link>
                    </div>
                </div>
			</g:form>
		</div>
	</body>
</html>
