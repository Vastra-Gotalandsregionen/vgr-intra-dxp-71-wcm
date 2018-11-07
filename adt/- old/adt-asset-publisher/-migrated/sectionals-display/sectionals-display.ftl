<#setting locale=locale>


<#assign aui = taglibLiferayHash["/WEB-INF/tld/aui.tld"] />
<#assign liferay_ui = taglibLiferayHash["/WEB-INF/tld/liferay-ui.tld"] />
<#assign liferay_util = taglibLiferayHash["/WEB-INF/tld/liferay-util.tld"] />
<#assign liferay_portlet = taglibLiferayHash["/WEB-INF/tld/liferay-portlet.tld"] />

<#assign portletNamespace = renderResponse.getNamespace() />

<div class="sectionals-listings-wrap">

  <#assign portletTitle = themeDisplay.getPortletDisplay().getTitle() />

  <#if portletTitle?lower_case != "innehållspresentatör" && portletTitle?lower_case != "asset publisher">
    <h1>${themeDisplay.getPortletDisplay().getTitle()}</h1>
  </#if>

  <div id="${portletNamespace}toggleControls" class="intra-panel-toggle-controls">
    <span class="toggle-control toggle-control-expand" id="${portletNamespace}toggleControlsExpandAll">
      F&auml;ll ut alla
    </span>
    <span class="toggle-control toggle-control-collapse hide" id="${portletNamespace}toggleControlsCollapseAll">
      F&auml;ll ihop alla
    </span>
  </div>

  <#if entries?has_content>

      <#assign panelContainerId = portletNamespace + "sectionalsPanelContainer" />

      <div class="intra-panel-container">
        <@liferay_ui["panel-container"] id=panelContainerId extended=true persistState=false >
          <#list entries as entry>

            <#assign docXml = saxReaderUtil.read(entry.getAssetRenderer().getArticle().getContentByLocale(locale)) />
            <#assign entryHeading = docXml.valueOf("//dynamic-element[@name='heading']/dynamic-content/text()") />
            <#assign entryContent = docXml.valueOf("//dynamic-element[@name='content']/dynamic-content/text()") />

            <#assign sections = docXml.selectNodes("//dynamic-element[@name='sectionHeading']") />

            <#assign displaySections = sections?size gt 1 />
            <#if sections?size == 1>
              <#assign displaySections =  (sections[0].valueOf("dynamic-content/text()") != "" )/>
            </#if>

            <#assign panelCssClass = "intra-panel" />
            <#if entryContent != "">
              <#assign panelCssClass = panelCssClass + " has-panel-content" />
            </#if>

            <#assign panelId = portletNamespace  + "panel_" + entry_index />

            <@liferay_ui.panel cssClass="${panelCssClass}" id=panelId collapsible=true defaultState="closed" extended=false persistState=false title="${entryHeading}">

              <#if entryContent != "">
                <div class="sectional-item-content">
                  ${entryContent}
                </div>
              </#if>

              <#if displaySections>
                <div class="intra-child-panel-container">
                  <#list sections as section>

                    <#assign sectionHeading = section.valueOf("dynamic-content/text()") />
                    <#assign sectionContent = section.valueOf("dynamic-element[@name='sectionContent']/dynamic-content/text()") />

                    <#assign childPanelCssClass = "intra-child-panel" />
                    <#if sectionContent != "">
                      <#assign childPanelCssClass = childPanelCssClass + " has-panel-content" />
                    </#if>

                    <#assign sectionPanelId = portletNamespace + "panel_" + entry_index + "_section" + section_index />

                    <@liferay_ui.panel cssClass="${childPanelCssClass}" id=sectionPanelId collapsible=true defaultState="closed" extended=true persistState=false title="${sectionHeading}">
                      <#if sectionContent != "">
                        <div class="sectional-item-section-content">
                          ${sectionContent}
                        </div>
                      </#if>
                    </@liferay_ui.panel>

                  </#list>
                </div>
              </#if>

            </@liferay_ui.panel>

          </#list>
        </@>
      </div>

      <@aui.script use="aui-toggler,liferay-store">

        var panelContainerId = '${panelContainerId}';
        var accordionComponentId = '${portletNamespace + panelContainerId}';
        var accordion = Liferay.component(accordionComponentId);
        var accordionPanelContainer = A.one('#' + panelContainerId);

        var toggleControlWrap = A.one('#${portletNamespace}toggleControls');
        var toggleLinks = A.all('#${portletNamespace}toggleControls .toggle-control');

        toggleLinks.on('click', function(e) {
          e.halt();
          var currentControl = e.currentTarget;

          if(currentControl.hasClass('toggle-control-expand')) {
            accordion.expandAll();
          }

          else if(currentControl.hasClass('toggle-control-collapse')) {
            accordion.collapseAll();
          }

          var siblings = currentControl.siblings();

          siblings.each(function(item) { item.show() });

          currentControl.hide();

        });


        toggleControlWrap.addClass('intra-panel-toggle-controls-ready');

      </@aui.script>


  </#if>

</div>
