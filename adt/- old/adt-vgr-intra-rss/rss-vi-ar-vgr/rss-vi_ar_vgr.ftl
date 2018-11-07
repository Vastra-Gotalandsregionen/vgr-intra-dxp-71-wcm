<#setting locale=locale>


<#assign liferay_ui = taglibLiferayHash["/WEB-INF/tld/liferay-ui.tld"] />
<#assign liferay_util = taglibLiferayHash["/WEB-INF/tld/liferay-util.tld"] />

<#assign liferay_portlet = taglibLiferayHash["/WEB-INF/tld/liferay-portlet.tld"] />

<#assign page = themeDisplay.getLayout() />
<#assign group_id = page.getGroupId() />
<#assign company_id = themeDisplay.getCompanyId() />

<div class="content-box we-are-vgr">

	<h2>${feedTitle}</h2>

	<div class="content-box-bd">
    <#list entries as entry>
        <a class="teaser-entry" href="${entry.link}" target="_BLANK">

					<div class="teaser-image">
						<!-- No image in RSS feed at this point. Include an empty image instead (background may be set by theme.) -->
						<img src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7">
					</div>

					<div class="teaser-content">
						<h3>
							${entry.title}
						</h3>
						<div class="date">
							${entry.publishedDate?string["dd MMM yyyy"]}
						</div>
					</div>

					<div class="link-wrap">
						<span class="fake-link">L&auml;s mer &raquo;</span>
					</div>

      </a>
    </#list>
	</div>

</div>
