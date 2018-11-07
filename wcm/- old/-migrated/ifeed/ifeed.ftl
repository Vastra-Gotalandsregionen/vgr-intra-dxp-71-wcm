<#assign namespace = request["portlet-namespace"]>

<div class="ifeed-parsed-wrap intra-list-wrap content-box">


	<#if heading.data != "">
		<h2>
			${heading.data}
		</h2>
	</#if>

	<div class="content-box-bd">

		<#if content.data != "">
			<div class="description">
				${content.data}
			</div>
		</#if>

		<div class="ifeed-consumer" data-templatenodeid="${namespace}feedTemplate">
			<#list feedUrl.siblings as feed>

				<div class="ifeed-parsed-container" data-url="${feed.data}" data-displaytype="${feed.feedTitle.displayType.data}">
					<#if feed.feedTitle.data != "">
						<h3 class="ifeed-parsed-title">
							<span>${feed.feedTitle.data}</span>
						</h3>
					</#if>
					<div id="${namespace}feedContainer${feed_index}" class="ifeed-parsed-content intra-list-content"></div>
				</div>
			</#list>
		</div>


	</div>

</div>

<#-- Template for results data -->
<script id="${namespace}feedTemplate" type="text/x-handlebars-template">
	<ul>
		{{#each this}}
			{{#ifCond [dc.format.extension.native] '==' 'pdf' }}
				<li class="pdf">
					<a href="{{[dc.identifier.native]}}" target="_BLANK">
						{{title}}
					</a>
				</li>
			{{else}}
				<li class="file">
					<a href="{{url}}" target="_BLANK">
						{{title}}
					</a>
			</li>
			{{/ifCond}}
		{{/each}}
	</ul>
</script>