<#setting locale=locale>

<#assign maxSummaryChars = 100 />
<#assign maxHeadingChars = 30 />

<div class="staff-week-listing">

  <h2>
    Min vecka
  </h2>

  <#if entries?has_content>
    <div class="staff-week-items">
      <#list entries as entry>

				<#assign assetRenderer = entry.getAssetRenderer() />
				<#assign viewURL = assetPublisherHelper.getAssetViewURL(renderRequest, renderResponse, entry) />

				<#if assetLinkBehavior != "showFullContent">
					<#assign viewURL = assetRenderer.getURLViewInContext(renderRequest, renderResponse, viewURL) />
				</#if>

        <#assign docXml = saxReaderUtil.read(entry.getAssetRenderer().getArticle().getContentByLocale(locale)) />
        <#assign itemHeading = docXml.valueOf("//dynamic-element[@name='heading']/dynamic-content/text()") />
        <#assign itemSummary = docXml.valueOf("//dynamic-element[@name='summary']/dynamic-content/text()") />
        <#assign itemImage = docXml.valueOf("//dynamic-element[@name='image']/dynamic-content/text()") />

        <div class="staff-week-item">
          <a href="${viewURL}">
            <div class="staff-week-item-inner">

              <div class="staff-week-item-heading">
                ${ellipsis(itemHeading, maxHeadingChars)}
              </div>

                <div class="staff-week-item-summary">
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
    <#return myString?substring(0, maxChars-3) + "..." />
  <#else>
    <#return myString />
  </#if>
</#function>
