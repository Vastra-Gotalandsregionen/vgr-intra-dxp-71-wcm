<div class="staff-week">
    <h1>
    	${heading.data}
    </h1>

		<div class="intro">
			<div class="image">
				<#if image.data?has_content>
					<img src="${image.data}" alt="Bild ${heading.data}" />
				</#if>
			</div>
			<div class="summary">
				${summary.data}
			</div>
		</div>

		<div class="content">
			${content.data}
		</div>
</div>
