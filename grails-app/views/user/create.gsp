

<%@ page import="socnet.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
        <div class="body shift">
            <h1>Register New Account</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${userInstance}">
            <div class="errors">
                <g:renderErrors bean="${userInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop hidden">
                                <td valign="top" class="name">
                                    <label for="apiKey"><g:message code="user.apiKey.label" default="Api Key" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'apiKey', 'errors')}">
                                    <g:textField name="apiKey" value="${userInstance?.apiKey}" />
                                </td>
                            </tr>
                        
                            <tr class="prop hidden">
                                <td valign="top" class="name">
                                    <label for="defaultContacts"><g:message code="user.defaultContacts.label" default="Default Contacts" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'defaultContacts', 'errors')}">
                                    <g:textField name="defaultContacts" value="${fieldValue(bean: userInstance, field: 'defaultContacts')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="login"><g:message code="user.login.label" default="User Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'login', 'errors')}">
                                    <g:textField name="login" value="${userInstance?.login}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="user.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${userInstance?.name}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="email"><g:message code="user.email.label" default="Email" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'email', 'errors')}">
                                    <g:textField name="email" value="${fieldValue(bean: userInstance, field: 'email')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="password"><g:message code="user.password.label" default="Password" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'password', 'errors')}">
                                    <g:passwordField name="password" value="" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="confirmPassword"><g:message code="user.confirmPassword.label" default="Confirm Password" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'confirmPassword', 'errors')}">
                                    <g:passwordField name="confirmPassword" value="" />
                                </td>
                            </tr>
                            
                        
                            <tr class="prop hidden">
                                <td valign="top" class="name">
                                    <label for="status"><g:message code="user.status.label" default="Status" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'status', 'errors')}">
                                    <g:textField name="status" value="${fieldValue(bean: userInstance, field: 'status')}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
