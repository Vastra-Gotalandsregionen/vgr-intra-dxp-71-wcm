<#setting locale=locale>

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

<div class="contacts-listing content-box">

  <h2>
    <#assign heading = "Kontaktpersoner" />
    <#assign portletTitle = themeDisplay.getPortletDisplay().getTitle() />

    <#if portletTitle?lower_case != "innehållspresentatör" && portletTitle?lower_case != "asset publisher">
      <#assign heading = portletTitle />
    </#if>

    ${heading}
  </h2>

  <div class="content-box-bd">

    <#if entries?has_content>
      <div class="news-items">
        <#list entries as entry>

          <#assign assetRenderer = entry.getAssetRenderer() />
          <#assign article = assetRenderer.getArticle() />

          <#assign docXml = saxReaderUtil.read(article.getContentByLocale(locale)) />
          <#assign contactName = docXml.valueOf("//dynamic-element[@name='name']/dynamic-content/text()") />
          <#assign contactTitle = docXml.valueOf("//dynamic-element[@name='jobTitle']/dynamic-content/text()") />
          <#assign contactEmail = docXml.valueOf("//dynamic-element[@name='email']/dynamic-content/text()") />
          <#assign contactPhone = docXml.valueOf("//dynamic-element[@name='phone']/dynamic-content/text()") />

          <div class="contact">

            <div class="pull-right">
              <@getEditIcon entry=entry />
            </div>


            <div class="contact-name">
              ${contactName}
            </div>

            <#if contactTitle != "">
            <div class="contact-title">
              ${contactTitle}
            </div>
            </#if>

            <#if contactEmail != "">
            <div class="contact-email">
              <a href ="mailto:${contactEmail}">
                ${contactEmail}
              </a>
            </div>
            </#if>

            <#if contactPhone != "">
            <div class="contact-phone">
              ${contactPhone}
            </div>
            </#if>

          </div>

        </#list>
      </div>
    </#if>

  </div>

</div>
