<%@ page import="org.ibntab.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
</head>

<body>
<a href="#edit-user" class="sr-only" tabindex="-1"><g:message code="default.link.skip.label"
                                                              default="Skip to content&hellip;"/></a>
<ol class="breadcrumb">
    <li><a href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
    <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]"/></g:link></li>
    <li class="active"><g:message code="default.edit.label" args="[entityName]"/></li>
</ol>

<div id="edit-user" role="main">
    <div class="page-header">
        <h1><g:message code="default.edit.label" args="[entityName]"/></h1>
    </div>
    <g:if test="${flash.message}">
        <div class="alert alert-info alert-dismissable" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${userInstance}">
        <ul class="errors" role="alert">
            <g:eachError bean="${userInstance}" var="error">
                <div class="alert alert-danger"
                     <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                        error="${error}"/></div>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <g:form class="form-horizontal" role="form" url="[resource: userInstance, action: 'update']" method="PUT">
        <g:hiddenField name="version" value="${userInstance?.version}"/>
        <g:render template="form"/>
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <g:actionSubmit class="save" action="update"
                                value="${message(code: 'default.button.update.label', default: 'Update')}"/>
                <g:link class="list" action="index"><g:message code="default.button.cancel.label"/></g:link>
            </div>
        </div>
    </g:form>
</div>
</body>
</html>
