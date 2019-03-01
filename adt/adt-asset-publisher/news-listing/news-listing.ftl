<#setting locale=locale>

<#assign page = themeDisplay.getLayout() />
<#assign group_id = page.getGroupId() />
<#assign company_id = themeDisplay.getCompanyId() />

<#assign expandoValueLocalService = serviceLocator.findService("com.liferay.expando.kernel.service.ExpandoValueLocalService") />
<#assign layoutLocalService = serviceLocator.findService("com.liferay.portal.kernel.service.LayoutLocalService")>

<#assign maxSummaryChars = 150 />
<#assign maxHeadingChars = 25 />

<#macro getEditIcon entry>
  <#if assetRenderer.hasEditPermission(themeDisplay.getPermissionChecker())>
    <#assign redirectURL = renderResponse.createRenderURL() />

    ${redirectURL.setParameter("mvcPath", "/add_asset_redirect.jsp")}
    ${redirectURL.setWindowState("pop_up")}

    <#assign editPortletURL = assetRenderer.getURLEdit(renderRequest, renderResponse, windowStateFactory.getWindowState("pop_up"), redirectURL)!"" />

    <#if validator.isNotNull(editPortletURL)>
      <#assign title = languageUtil.format(locale, "edit-x", entry.getTitle(locale), false) />

      <@liferay_ui["icon"]
        cssClass="icon-monospaced visible-interaction"
        icon="pencil"
        markupView="lexicon"
        message=title
        url="javascript:Liferay.Util.openWindow({id:'" + renderResponse.getNamespace() + "editAsset', title: '" + title + "', uri:'" + htmlUtil.escapeURL(editPortletURL.toString()) + "'});"
      />
    </#if>
  </#if>
</#macro>



<div class="news-listing">

  <h1>
    Nyheter
  </h1>

  <#if entries?has_content>
    <div class="news-items">
      <#list entries as entry>

        <#assign assetRenderer = entry.getAssetRenderer() />
        <#assign viewURL = assetPublisherHelper.getAssetViewURL(renderRequest, renderResponse, entry) />

        <#if assetLinkBehavior != "showFullContent">
          <#assign viewURL = assetRenderer.getURLViewInContext(renderRequest, renderResponse, viewURL) />
        </#if>

        <#assign docXml = saxReaderUtil.read(entry.getAssetRenderer().getArticle().getContentByLocale(locale)) />
        <#assign itemHeading = docXml.valueOf("//dynamic-element[@name='heading']/dynamic-content/text()") />
        <#assign itemSummary = docXml.valueOf("//dynamic-element[@name='summary']/dynamic-content/text()") />
        <#assign itemContent = docXml.valueOf("//dynamic-element[@name='content']/dynamic-content/text()") />
        <#assign itemDate = docXml.valueOf("//dynamic-element[@name='date']/dynamic-content/text()") />
        <#assign itemType = docXml.valueOf("//dynamic-element[@name='type']/dynamic-content/text()") />

        <#assign itemContent = htmlUtil.stripHtml(itemContent) />
        <#if !itemSummary?has_content>
          <#assign itemSummary = itemContent />
        </#if>

        <div class="news-item news-item-${itemType}">
            <#--
            <div class="pull-right">
              <@getEditIcon entry=entry />
            </div>
            -->

          <a href="${viewURL}">
            <div class="news-item-inner">
              <div class="news-item-date">
                ${itemDate}
              </div>
              <div class="news-item-heading">
                <#--
                ${ellipsis(itemHeading, maxHeadingChars)}
                -->
                ${itemHeading}
              </div>
              <div class="news-item-summary">
                ${ellipsis(itemSummary, maxSummaryChars)}
              </div>
            </div>
          </a>
        </div>

      </#list>
    </div>
  </#if>

</div>

<#function ellipsis myString maxChars>
  <#if myString?length gt maxChars>
    <#return myString?substring(0, maxChars) + "..." />
  <#else>
    <#return myString />
  </#if>
</#function>
