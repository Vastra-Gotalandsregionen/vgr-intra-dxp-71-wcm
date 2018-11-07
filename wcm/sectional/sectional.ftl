<div class="sectional-wrap">

  <h1>
    ${heading.data}
  </h1>
  <div class="sectional-content">
    ${content.data}
  </div>

  <#if sectionHeading.siblings[0].data != "">
    <div class="sectional-sections">
      <#list sectionHeading.siblings as section>
        <div class="sectional-section">
          <h2>
            ${section.data}
          </h2>
          <div class="sectional-section-content">
            ${section.sectionContent.data}
          </div>
        </div>
      </#list>

    </div>
  </#if>

</div>
