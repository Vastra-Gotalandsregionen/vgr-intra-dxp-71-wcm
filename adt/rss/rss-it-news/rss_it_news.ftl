<#--
-->
<#if entries?has_content>

  <#assign dateFormat = "dd MMMM - HH:mm" />

  <div class="blogs-listing content-box">

    <#list entries as curEntry>

      <#assign rssFeedTitle = curEntry.getTitle() />
      <#assign rssFeedEntries = curEntry.getRSSFeedEntries(themeDisplay) />

      <h2>${rssFeedTitle}</h2>

      <div class="content-box-bd">
        <div class="news-items">
          <#list rssFeedEntries as rssFeedEntry>
            <div class="entry-item">

              <#assign syndEntry = rssFeedEntry.getSyndEntry() />
              <#assign entryLink = htmlUtil.escapeJSLink(rssFeedEntry.getSyndEntryLink()) />
              <#assign entryTitle = htmlUtil.escape(syndEntry.getTitle()) />

              <#--
              <#assign entryPublishedDate = syndEntry.getPublishedDate() />
              <#assign entryPublishedMonth = dateUtil.getDate(entryPublishedDate, "MMM", locale) />
              <#assign entryPublishedDay = dateUtil.getDate(entryPublishedDate, "dd", locale) />
              -->

              <#assign entryPublishedMonth = "okt" />
              <#assign entryPublishedDay = "10" />


              <a href="${entryLink}" target="_blank" rel="noopener">
      					<div class="entry-date">
      						<div class="entry-date-inner">
      							<div class="entry-date-month">${entryPublishedMonth}</div>
      							<div class="entry-date-day">${entryPublishedDay}</div>
      						</div>
      					</div>
      					<div class="entry-content news-title-minimal">${entryTitle}</div>
      				</a>

            </div>
          </#list>
        </div>
      </div>

    </#list>
  </div>

</#if>


<#--

<#if entries?has_content>
    <#assign dateFormat = "dd MMMM - HH:mm" />

    <#list entries as curEntry>
        <#assign rssFeedEntries = curEntry.getRSSFeedEntries(themeDisplay) />

        <#if rssFeedEntries??>
            <div id="tab-${curEntry_index}" class="tab-pane">
                <#list rssFeedEntries as rssFeedEntry>
                    <#if (rssFeedEntry_index > entriesPerFeed?number)>
                        <#break>
                    </#if>


                    <#assign entryCss = "">
                        <#if rssFeedEntry?index = 0>
                            <#assign entryCss = "first">
                        </#if>

                        <#assign syndEntry = rssFeedEntry.getSyndEntry() />

                        <div class="rss-entry ${entryCss}">
                            <#if syndEntry.getTitle()??>
                                <h4>
                                    <#if rssFeedEntry.getSyndEntryLink()??>
                                        <a href="${htmlUtil.escapeJSLink(rssFeedEntry.getSyndEntryLink())}" rel="noopener">
                                    </#if>
                                    ${htmlUtil.escape(syndEntry.getTitle())}
                                    <#if rssFeedEntry.getSyndEntryLink()??>
                                        </a>
                                    </#if>
                                </h4>
                            </#if>

                            <#if syndEntry.getPublishedDate()??><span class="rss-date">${dateUtil.getDate(syndEntry.getPublishedDate(), dateFormat, locale)}</span></#if>

                            <#if rssFeedEntry.getSanitizedContent()??>
                              ${htmlUtil.unescape(rssFeedEntry.getSanitizedContent())}
                            </#if>

                        </div>


                        <#if syndEntry.getAuthor()??>

                        </#if>

                </#list>
            </div>
        </#if>
    </#list>


</#if>
-->
