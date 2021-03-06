<%--
/**
 * Copyright (c) 2000-present Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
--%>

<%@ include file="/html/portlet/layout_set_prototypes/init.jsp" %>

<%
String redirect = ParamUtil.getString(request, "redirect");

String backURL = ParamUtil.getString(request, "backURL", redirect);

LayoutSetPrototype layoutSetPrototype = null;

long layoutSetPrototypeId = ParamUtil.getLong(request, "layoutSetPrototypeId");

if (layoutSetPrototypeId > 0) {
	layoutSetPrototype = LayoutSetPrototypeServiceUtil.fetchLayoutSetPrototype(layoutSetPrototypeId);
}
else {
	Group group = themeDisplay.getScopeGroup();

	if (group.isLayoutSetPrototype()) {
		layoutSetPrototype = LayoutSetPrototypeLocalServiceUtil.fetchLayoutSetPrototype(group.getClassPK());

		layoutSetPrototypeId = layoutSetPrototype.getLayoutSetPrototypeId();
	}
}

if (layoutSetPrototype == null) {
	layoutSetPrototype = new LayoutSetPrototypeImpl();

	layoutSetPrototype.setNew(true);
	layoutSetPrototype.setActive(true);
}

boolean layoutsUpdateable = GetterUtil.getBoolean(layoutSetPrototype.getSettingsProperty("layoutsUpdateable"), true);

Group group = themeDisplay.getSiteGroup();
%>

<liferay-ui:success key='<%= PortletKeys.SITE_TEMPLATE_SETTINGS + "requestProcessed" %>' message="site-template-was-added" />

<c:if test="<%= !group.isLayoutSetPrototype() %>">
	<liferay-util:include page="/html/portlet/layout_set_prototypes/toolbar.jsp">
		<liferay-util:param name="toolbarItem" value='<%= layoutSetPrototype.isNew() ? "add" : StringPool.BLANK %>' />
	</liferay-util:include>

	<liferay-ui:header
		backURL="<%= backURL %>"
		localizeTitle="<%= layoutSetPrototype.isNew() %>"
		title='<%= layoutSetPrototype.isNew() ? "new-site-template" : layoutSetPrototype.getName(locale) %>'
	/>
</c:if>

<%
request.setAttribute("edit_layout_set_prototype.jsp-layoutSetPrototype", layoutSetPrototype);
request.setAttribute("edit_layout_set_prototype.jsp-redirect", currentURL);
%>

<liferay-util:include page="/html/portlet/layout_set_prototypes/merge_alert.jsp" />

<portlet:actionURL name="updateLayoutSetPrototype" var="updateLayoutSetPrototypeURL" />

<aui:form action="<%= updateLayoutSetPrototypeURL %>" method="post" name="fm">
	<aui:input name="redirect" type="hidden" value="<%= redirect %>" />
	<aui:input name="layoutSetPrototypeId" type="hidden" value="<%= layoutSetPrototypeId %>" />

	<aui:model-context bean="<%= layoutSetPrototype %>" model="<%= LayoutSetPrototype.class %>" />

	<aui:fieldset>
		<aui:input autoFocus="<%= windowState.equals(WindowState.MAXIMIZED) %>" name="name" />

		<aui:input name="description" />

		<aui:input name="active" />

		<aui:input helpMessage="allow-site-administrators-to-modify-pages-associated-with-this-site-template-help" label="allow-site-administrators-to-modify-pages-associated-with-this-site-template" name="layoutsUpdateable" type="checkbox" value="<%= layoutsUpdateable %>" />

		<%
		Set<String> servletContextNames = CustomJspRegistryUtil.getServletContextNames();

		String customJspServletContextName = StringPool.BLANK;

		if (layoutSetPrototype != null) {
			UnicodeProperties settingsProperties = layoutSetPrototype.getSettingsProperties();

			customJspServletContextName = GetterUtil.getString(settingsProperties.get("customJspServletContextName"));
		}
		%>

		<c:if test="<%= !servletContextNames.isEmpty() %>">
			<aui:select label="application-adapter" name="customJspServletContextName">
				<aui:option label="none" />

				<%
				for (String servletContextName : servletContextNames) {
				%>

					<aui:option selected="<%= customJspServletContextName.equals(servletContextName) %>" value="<%= servletContextName %>"><%= CustomJspRegistryUtil.getDisplayName(servletContextName) %></aui:option>

				<%
				}
				%>

			</aui:select>
		</c:if>

		<aui:button-row>
			<aui:button type="submit" />

			<aui:button href="<%= redirect %>" type="cancel" />
		</aui:button-row>
	</aui:fieldset>
</aui:form>

<%
if (!layoutSetPrototype.isNew()) {
	PortalUtil.addPortletBreadcrumbEntry(request, layoutSetPrototype.getName(locale), null);
	PortalUtil.addPortletBreadcrumbEntry(request, LanguageUtil.get(request, "edit"), currentURL);
}
else {
	PortalUtil.addPortletBreadcrumbEntry(request, LanguageUtil.get(request, "add-page"), currentURL);
}
%>