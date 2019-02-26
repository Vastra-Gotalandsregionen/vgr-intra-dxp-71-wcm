<#setting locale=locale />

<#assign layoutLocalService = serviceLocator.findService("com.liferay.portal.kernel.service.LayoutLocalService")>

<#include "${templatesPath}/NAVIGATION-MACRO-FTL" />

<#if !entries?has_content>
	<#if themeDisplay.isSignedIn()>
		<div class="alert alert-info">
			<@liferay.language key="there-are-no-menu-items-to-display" />
		</div>
	</#if>
<#else>
	<#assign includeAllChildNavItems = false />

	<#if stringUtil.equals(includedLayouts, "all")>
		<#assign includeAllChildNavItems = true />
	</#if>

	<#assign firstEntry = entries[0] />
	<#assign firstEntryLayout = firstEntry.getLayout () />
	<#assign firstEntryParentPlid = firstEntryLayout.getParentPlid() />
	<#assign firstEntryParent = layoutLocalService.getLayout(firstEntryParentPlid) />
	<#assign navTitle = firstEntryParent.getName(locale) />

	<div aria-label="<@liferay.language key="site-pages" />" class="nav-menu">

		<h2>${navTitle}</h2>

		<@buildNavigation
			branchNavItems=branchNavItems
			cssClass="layouts"
			displayDepth=displayDepth
			includeAllChildNavItems=includeAllChildNavItems
			navItemLevel=1
			navItems=entries
		/>
	</div>

</#if>
