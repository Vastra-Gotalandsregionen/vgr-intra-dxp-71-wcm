<#setting locale=locale>


<#assign liferay_ui = taglibLiferayHash["/WEB-INF/tld/liferay-ui.tld"] />
<#assign liferay_util = taglibLiferayHash["/WEB-INF/tld/liferay-util.tld"] />

<#assign liferay_portlet = taglibLiferayHash["/WEB-INF/tld/liferay-portlet.tld"] />

<#assign page = themeDisplay.getLayout() />
<#assign group_id = page.getGroupId() />
<#assign company_id = themeDisplay.getCompanyId() />

<div class="content-box content-box-simple content-box-wide">

	<div class="content-box-bd">
    <#list entries as entry>

			<div class="entry-item">
				<a href="${entry.link}" target="_blank">
					<div class="entry-date">
						<div class="entry-date-inner">
							<div class="entry-date-month">
								<#if entry.startDate?has_content>
									${entry.startDate?string["MMM"]}
								<#else>
									${entry.publishedDate?string["MMM"]}
								</#if>
							</div>
							<div class="entry-date-day">
								<#if entry.startDate?has_content>
									${entry.startDate?string["dd"]}
								<#else>
									${entry.publishedDate?string["dd"]}
								</#if>
							</div>
						</div>
					</div>
					<div class="entry-content">

						<h3>
							${entry.title}
						</h3>

						<#if entry.startDate?has_content || entry.endDate?has_content>
							<span class="time">
								<i class="icon-time"></i> (${entry.startDate?string["dd/MM"]}) ${entry.startTime?string["hh.mm"]} - (${entry.endDate?string["dd/MM"]}) ${entry.endTime?string["hh.mm"]}
							</span>
						</#if>

						<#if entry.location?has_content>
							<span class="place">
								<i class="icon-map-marker"></i> ${entry.location!}
							</span>
						</#if>

					</div>
				</a>
			</div>

    </#list>
	</div>

</div>
