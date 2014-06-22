<%@ page import="org.ibntab.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<a href="#list-user" class="sr-only" tabindex="-1"><g:message code="default.link.skip.label"
                                                              default="Skip to content&hellip;"/></a>
<ol class="breadcrumb">
    <li><a href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
    <li class="active"><g:message code="default.list.label" args="[entityName]"/></li>
</ol>

<div id="list-user" role="main">
    <div class="page-header">
        <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    </div>
    <g:if test="${flash.message}">
        <div class="alert alert-info alert-dismissable" role="status">${flash.message}</div>
    </g:if>
    <table class="table">
        <thead>
        <tr>

            <g:sortableColumn property="username" title="${message(code: 'user.username.label', default: 'Username')}"/>

            <g:sortableColumn property="accountExpired"
                              title="${message(code: 'user.accountExpired.label', default: 'Account Expired')}"/>

            <g:sortableColumn property="accountLocked"
                              title="${message(code: 'user.accountLocked.label', default: 'Account Locked')}"/>

            <g:sortableColumn property="enabled" title="${message(code: 'user.enabled.label', default: 'Enabled')}"/>

            <g:sortableColumn property="passwordExpired"
                              title="${message(code: 'user.passwordExpired.label', default: 'Password Expired')}"/>

        </tr>
        </thead>
        <tbody>
        <g:each in="${userInstanceList}" status="i" var="userInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td><g:link action="show"
                            id="${userInstance.id}">${fieldValue(bean: userInstance, field: "username")}</g:link></td>

                <td><bs:formatBoolean boolean="${userInstance.accountExpired}"/></td>

                <td><bs:formatBoolean boolean="${userInstance.accountLocked}"/></td>

                <td><bs:formatBoolean boolean="${userInstance.enabled}"/></td>

                <td><bs:formatBoolean boolean="${userInstance.passwordExpired}"/></td>

            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${userInstanceCount ?: 0}"/>
    </div>
</div>
</body>
</html>
