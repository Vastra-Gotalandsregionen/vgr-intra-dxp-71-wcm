<#assign namespace = request["portlet-namespace"]>

<div id="${namespace}IntraListWrap" class="intra-list-wrap content-box">

	<h2>
		${heading.data}
	</h2>

	<div class="content-box-bd">

		<#if content.data != "">
			<div class="description">
				${content.data}
			</div>
		</#if>

			<#list sectionTitle.siblings as section>

				<div class="intra-link-section intra-list-section" data-displaytype="${section.displayType.data}">

					<#if section.data != "">
						<h3 class="intra-links-title">
							<span>${section.data}</span>
						</h3>
					</#if>

					<div class="intra-links-content intra-list-content">
						<ul>
							<#list section.linkUrl.siblings as link>

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

			</#list>

	</div>

</div>

<#-- Logic toggle sections -->
<script>

	AUI().ready('aui-base', 'aui-toggler', function(A) {

		var namespace = '${namespace}';

		var sectionNodes = A.all('#' + namespace + 'IntraListWrap .intra-link-section');

		console.log('sectionNodes', sectionNodes);

		sectionNodes.each(function(item, index, list) {

			var displayType = item.getAttribute('data-displaytype');
			var titleNode = item.one('.intra-links-title');
			var contentNode = item.one('.intra-links-content');
			var hasTitleNode = false;
			if(titleNode) {
				hasTitleNode = true;
			}

			if(hasTitleNode && (displayType == 'collapsible-open' || displayType == 'collapsible-closed') ) {
				var expanded = true;

				if(displayType == 'collapsible-closed') {
					expanded = false;
				}

				var toggler = new A.Toggler({
					animated: true,
					container: item,
					content: contentNode,
					expanded: expanded,
					header: titleNode
				});

				item.addClass('intra-list-section-collapsible');

			}


		});


	});

</script>
