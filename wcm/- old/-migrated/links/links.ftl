<#--
<#assign namespace = request["portlet-namespace"]>
-->

<div class="intra-list-wrap content-box">

	<h2>
		${heading.data}
	</h2>

	<div class="content-box-bd">

		<#if content.data != "">
			<div class="description">
				${content.data}
			</div>
		</#if>

		<div class="intra-list-content">
			<ul>
				<#list linkUrl.siblings as link>

					<#assign currentUrl = link.data />
					<#if !currentUrl?starts_with("http://") && !currentUrl?starts_with("https://") >
						<#assign currentUrl = "http://" + currentUrl />
					</#if>

					<li>
						<a href="${currentUrl}" target="${link.target.data}">
							${link.linkTitle.data}
						</a>
					</li>

				</#list>
			</ul>
		</div>


	</div>

</div>
