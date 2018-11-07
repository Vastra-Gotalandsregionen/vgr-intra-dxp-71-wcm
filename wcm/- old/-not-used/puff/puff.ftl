<#assign namespace = request["portlet-namespace"]!>

<#-- Decide if block should be shown or not -->
<#assign showBlock = true />
<#if showFor.data == "signedin" && !permissionChecker.isSignedIn()>
  <#assign showBlock = false />
<#elseif showFor.data == "signedout" && permissionChecker.isSignedIn()>
  <#assign showBlock = false />
</#if>

<#if showBlock>
  <div class="content-box puff-box">
    <h2>
      ${heading.data}
    </h2>
    <div class="content-box-bd">
      ${content.data}

      <#if linkButton.data != "" >

        <#assign linkTitle = linkButton.data />
        <#assign linkUrl = linkButton.linkUrl.data />
        <#assign linkIcon = linkButton.linkIcon.data />

        <a href="${linkUrl}" class="link-button link-button-icon link-button-icon-${linkIcon}">
          ${linkTitle} &raquo;
        </a>
      </#if>
    </div>
  </div>
</#if>

<#if !showBlock>
  <script>
    ${namespace}namespace = '${namespace}';

    <#-- Remove extra underscore at the end of namespace if exists -->
    //${namespace}namespaceFixed = ${namespace}namespace.replace(/_\s*$/, "");

    ${namespace}portletBoundaryNode = document.getElementById('p_p_id' +  ${namespace}namespace);
    ${namespace}portletBoundaryNode.className = ${namespace}portletBoundaryNode.className + " no-portlet-content";

  </script>
</#if>
