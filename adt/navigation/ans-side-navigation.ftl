<div class="nav-menu">


  <#if entries?has_content>

    <ul class="layouts level-1">

    	<#list entries as navItem>
        <li>
          <a href="${navItem.getURL()}">
            ${navItem.getName()}
          </a>
        </li>

    	</#list>


    </ul>

  </#if>



</div>
