<#-- Define services -->
<#assign groupLocalService = serviceLocator.findService("com.liferay.portal.service.GroupLocalService") >
<#assign layoutLocalService = serviceLocator.findService("com.liferay.portal.service.LayoutLocalService") >

<#-- Define some variables -->
<#assign portletNamespace = "" />
<#if request["portlet-namespace"]?has_content>
	<#assign portletNamespace = request["portlet-namespace"] />
	<#assign portletNamespace = trimPortletNamespace(portletNamespace) />
</#if>

<#assign maxDescriptionChars = 140 />

<nav role="navigation" class="block-navigation" id="${portletNamespace}blockNavigation">
	<#if pages.siblings?has_content>
		<#list pages.siblings as page>

			<#-- Get Page Layout -->
			<#assign pageData = page.data?split("@") />

			<#assign pageLayoutId =  getterUtil.getLong(pageData[0]) />

			<#assign pageLayoutIsPrivate =  false />
			<#if pageData[1] == "private">
				<#assign pageLayoutIsPrivate = true />
			</#if>

			<#assign pageLayoutGroupId = getterUtil.getLong(pageData[2]) />

			<#assign pageLayout = layoutLocalService.getLayout(pageLayoutGroupId, pageLayoutIsPrivate, pageLayoutId) >


			<div class="block-navigation-item">
				<a href="${pageLayout.friendlyURL}">
					<div class="title">${pageLayout.getName(locale) }</div>

					<div class="img-wrap">
						<#if page.image.data?has_content>
							<img src="${page.image.data}" alt="ikon" />
						<#else>
							&nbsp;
						</#if>
					</div>

					<div class="description">
						${ellipsis(page.description.data, maxDescriptionChars)}
					</div>
				</a>
			</div>
		</#list>
	</#if>

</nav>



<script type="text/javascript">

	var ${portletNamespace}portletNode = document.getElementById('portlet${portletNamespace}');

	${portletNamespace}portletNode.className = ${portletNamespace}portletNode.className + ' portlet-bg-transp';


</script>


<#function trimPortletNamespace text>
	<#if text[text?length-1] = "_">
		<#local text = text?substring(0, text?length-1) />
	</#if>
	<#return text />
</#function>

<#function ellipsis myString maxChars>
	<#if myString?length gt maxChars>
		<#return myString?substring(0, maxChars) + "..." />
	<#else>
		<#return myString />
	</#if>
</#function>
