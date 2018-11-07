<#setting locale=locale>

<#assign liferay_ui = taglibLiferayHash["/WEB-INF/tld/liferay-ui.tld"] />
<#assign liferay_util = taglibLiferayHash["/WEB-INF/tld/liferay-util.tld"] />

<#assign liferay_portlet = taglibLiferayHash["/WEB-INF/tld/liferay-portlet.tld"] />

<#assign page = themeDisplay.getLayout() />
<#assign group_id = page.getGroupId() />
<#assign company_id = themeDisplay.getCompanyId() />

<#assign expandoValueLocalService = serviceLocator.findService("com.liferay.portlet.expando.service.ExpandoValueLocalService") />
<#assign layoutLocalService = serviceLocator.findService("com.liferay.portal.service.LayoutLocalService")>

<#assign maxItemsToDisplay = 1 />

<#assign maxSummaryChars = 80 />

<div class="staff-week-box content-box">
  <#if entries?has_content>
    <#list entries as entry>

      <#if entry_index gte maxItemsToDisplay>
        <#break>
      </#if>

      <#assign assetRenderer = entry.getAssetRenderer() />
      <#assign viewURL = assetPublisherHelper.getAssetViewURL(renderRequest, renderResponse, entry) />

      <#if assetLinkBehavior != "showFullContent">
        <#assign viewURL = assetRenderer.getURLViewInContext(renderRequest, renderResponse, viewURL) />
      </#if>

      <#assign article = assetRenderer.getArticle() />
      <#assign docXml = saxReaderUtil.read(article.getContentByLocale(locale)) />
      <#assign itemHeading = docXml.valueOf("//dynamic-element[@name='heading']/dynamic-content/text()") />
      <#assign itemSummary = docXml.valueOf("//dynamic-element[@name='summary']/dynamic-content/text()") />
      <#assign itemImage = docXml.valueOf("//dynamic-element[@name='image']/dynamic-content/text()") />


      <h2>
        ${itemHeading}
      </h2>

      <div class="content-box-bd">
        <a href="${viewURL}">

          <p>
            ${ellipsis(itemSummary, maxSummaryChars)} <span class="fake-link" href="${viewURL}">L&auml;s mer &raquo; </span>
          </p>

          <div class="img-wrap">
            <img src="${itemImage}" alt"Img" />
          </div>

        </a>
      </div>
    </#list>

    <#assign entry = entries[0] />
    <#assign article = entry.getAssetRenderer().getArticle() />
    <#assign displayPageUuid = article.getLayoutUuid() />
    <#assign displayPage = layoutLocalService.fetchLayoutByUuidAndGroupId(displayPageUuid, group_id, page.isPrivateLayout())! />
    <#if displayPage?has_content>
      <#assign displayPageUrl = displayPage.getFriendlyURL(locale) />
      <div class="more-link-wrap">
        <a href="${displayPageUrl}" class="more-link">Fler min vecka &raquo;</a>
      </div>
    </#if>

  </#if>
</div>

<#function ellipsis myString maxChars>
  <#if myString?length gt maxChars>
    <#return myString?substring(0, maxChars) + "..." />
  <#else>
    <#return myString />
  </#if>
</#function>
