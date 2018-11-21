<#setting locale=locale>

<#assign page = themeDisplay.getLayout() />
<#assign group_id = page.getGroupId() />
<#assign company_id = themeDisplay.getCompanyId() />

<#assign assetEntryLocalService = serviceLocator.findService("com.liferay.asset.kernel.service.AssetEntryLocalService")>
<#assign dlFileEntryLocalService = serviceLocator.findService("com.liferay.document.library.kernel.service.DLFileEntryLocalService")>
<#assign expandoValueLocalService = serviceLocator.findService("com.liferay.expando.kernel.service.ExpandoValueLocalService") />
<#assign layoutLocalService = serviceLocator.findService("com.liferay.portal.kernel.service.LayoutLocalService")>

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

      <#assign itemImageUrl = getArticleDLEntryUrl(itemImage) />


      <h2>
        ${itemHeading}
      </h2>

      <div class="content-box-bd">
        <a href="${viewURL}">

          <p>
            ${ellipsis(itemSummary, maxSummaryChars)} <span class="fake-link" href="${viewURL}">L&auml;s mer &raquo; </span>
          </p>

          <div class="img-wrap">
            <img src="${itemImageUrl}" alt"Img" />
          </div>

        </a>
      </div>
    </#list>

    <#assign entry = entries[0] />
    <#assign article = entry.getAssetRenderer().getArticle() />
    <#assign displayPageUuid = article.getLayoutUuid() />
    <#assign displayPage = layoutLocalService.fetchLayoutByUuidAndGroupId(displayPageUuid, group_id, page.isPrivateLayout())! />
    <#if displayPage?has_content>
      <#assign displayPageUrl = portalUtil.getLayoutFriendlyURL(displayPage, themeDisplay, locale) />

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

<#--
Function that returns the download url for a DLFileEntry in an article
Params: xmlValue = the xml-value of the DLFileEntry node in the article XML.
If structure field for the DLFileEntry is called image, the xmlValue can be retrieved by
<#assign xmlValue = docXml.valueOf("//dynamic-element[@name='image']/dynamic-content/text()") />
Returns: the download-url of the DLFileEntry

Requires the following services located in ADT:
<#assign assetEntryLocalService = serviceLocator.findService("com.liferay.asset.kernel.service.AssetEntryLocalService")>
<#assign dlFileEntryLocalService = serviceLocator.findService("com.liferay.document.library.kernel.service.DLFileEntryLocalService")>
-->
<#function getArticleDLEntryUrl xmlValue>
  <#local docUrl = "" />

  <#if xmlValue?has_content>
    <#local jsonObject = xmlValue?eval />

    <#local entryUuid = jsonObject.uuid />
    <#local entryGroupId = getterUtil.getLong(jsonObject.groupId) />

    <#local dlFileEntry = dlFileEntryLocalService.getDLFileEntryByUuidAndGroupId(entryUuid, entryGroupId) />

    <#local assetEntry = assetEntryLocalService.getEntry("com.liferay.document.library.kernel.model.DLFileEntry", dlFileEntry.fileEntryId) />
    <#local assetRenderer = assetEntry.assetRenderer />

    <#local docUrl = assetRenderer.getURLDownload(themeDisplay) />
  </#if>
  <#return docUrl />
</#function>
