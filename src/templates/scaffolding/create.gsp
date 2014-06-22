<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#create-${domainClass.propertyName}" class="sr-only" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<ol class="breadcrumb">
            <li><a href="\${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
            <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
            <li class="active"><g:message code="default.create.label" args="[entityName]" /></li>
		</ol>
		<div id="create-${domainClass.propertyName}" role="main">
            <div class="page-header">
                <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            </div>
			<g:if test="\${flash.message}">
			<div class="alert alert-info alert-dismissable" role="status">\${flash.message}</div>
			</g:if>
			<g:hasErrors bean="\${${propertyName}}">
				<g:eachError bean="\${${propertyName}}" var="error">
				<div class="alert alert-danger" <g:if test="\${error in org.springframework.validation.FieldError}">data-field-id="\${error.field}"</g:if>><g:message error="\${error}"/></div>
				</g:eachError>
			</g:hasErrors>
			<g:form class="form-horizontal" role="form" url="[resource:${propertyName}, action:'save']" <%= multiPart ? ' enctype="multipart/form-data"' : '' %>>
                <g:render template="form"/>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <g:submitButton name="create" class="save" value="\${message(code: 'default.button.create.label', default: 'Create')}" />
                        <g:link class="list" action="index"><g:message code="default.button.cancel.label"/> </g:link>
                    </div>
                </div>
			</g:form>
		</div>
	</body>
</html>
