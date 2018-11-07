<#setting locale=locale>


<#assign liferay_ui = taglibLiferayHash["/WEB-INF/tld/liferay-ui.tld"] />
<#assign liferay_util = taglibLiferayHash["/WEB-INF/tld/liferay-util.tld"] />

<#assign liferay_portlet = taglibLiferayHash["/WEB-INF/tld/liferay-portlet.tld"] />

<#assign page = themeDisplay.getLayout() />
<#assign group_id = page.getGroupId() />
<#assign company_id = themeDisplay.getCompanyId() />

<#assign expandoValueLocalService = serviceLocator.findService("com.liferay.portlet.expando.service.ExpandoValueLocalService") />
<#assign layoutLocalService = serviceLocator.findService("com.liferay.portal.service.LayoutLocalService")>

<#assign maxSummaryChars = 150 />
<#assign maxHeadingChars = 25 />

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
        <#assign itemDate = itemDate?number?long?number_to_datetime?string("yyyy-MM-dd")>
        <#assign itemType = docXml.valueOf("//dynamic-element[@name='type']/dynamic-content/text()") />

        <#assign itemContent = htmlUtil.stripHtml(itemContent) />
        <#if !itemSummary?has_content>
          <#assign itemSummary = itemContent />
        </#if>

        <div class="news-item news-item-${itemType}">
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
