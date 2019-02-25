<#--
<#assign newsDate = date.data?number?long?number_to_datetime?string("yyyy-MM-dd")>
-->

<div class="news-item">
	<div class="news-date">${date.data}</div>
	<h1>${heading.data}</h1>
	<div class="news-summary">${summary.data}</div>
	<#if featuredImage.data != "">
		<img class="featured-image" src="${featuredImage.getData()}" alt="${heading.data}" />
	</#if>
	<div class="news-content">${content.data}</div>
</div>
