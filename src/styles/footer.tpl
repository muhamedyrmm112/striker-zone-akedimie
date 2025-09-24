{block name='layout-footer'}

    {block name='layout-footer-content-all-closingtags'}

        {block name='layout-footer-aside'}
            {if ($smarty.const.PAGE_ARTIKELLISTE === $nSeitenTyp || $Einstellungen.template.theme.left_sidebar === 'Y')
                && !$bExclusive
                && $boxesLeftActive
            }
                {block name='layout-footer-content-productlist-col-closingtag'}
                    </div>{* /col *}
                {/block}
                {*
                {block name='layout-footer-sidepanel-left'}
                    {if !$isMobile || $isTablet}
                        <aside id="sidepanel_left" class="sidepanel-left d-print-none col-12 col-lg-3 col-xl-3 order-lg-0 d-none d-lg-block d-xl-block dropdown-full-width">
                            {block name='footer-sidepanel-left-content'}<div class="inner{if $Einstellungen.template.productlist.sidebar_fixed==='Y'} sticky-top{/if}">{$boxes.left}</div>{/block}
                        </aside>
                    {/if}
                {/block}
                *}
                {block name='layout-footer-content-productlist-row-closingtag'}
                    </div>{* /row *}
                {/block}
            {/if}
        {/block}

        {block name='layout-footer-content-closingtag'}
            {opcMountPoint id='opc_content' title='Default Area' inContainer=false}
            </div>{* /content *}
        {/block}

        {block name='layout-footer-content-wrapper-closingtag'}
            </div>{* /content-wrapper*}
        {/block}
    {/block}
          
    {block name='layout-footer-main-wrapper-closingtag'}
        </main> {* /mainwrapper *}
        {$endpages = false}
        {if $nSeitenTyp == $smarty.const.PAGE_BESTELLVORGANG || $nSeitenTyp == $smarty.const.PAGE_WARENKORB}
            {$endpages = true}
        {/if}
        {if $endpages == true}
         </div> {* /col-md-9 close  *}
        </div>  {* /row-sidebarcart  *}
         </div> {* /container sidebarcart *}
        </div>{* /waren_parent close *} 
        {/if}
    {/block}

    {block name='layout-footer-content'}
        {if !$bExclusive}

            {block name='layout-footer-logo'}
                {capture name="logo"}
                    <div class="logo-wrapper mb-3">
                        {include file='snippets/logo.tpl' position='footer'}
                    </div>
                {/capture}
            {/block}

            {$newsletterLeisteActive = $Einstellungen.template.footer.newsletter_footer === 'Y' && $Einstellungen.newsletter.newsletter_active === 'Y'}
            {$newsletterPlaceholderActive = $Einstellungen.template.footer.newsletter_footer === 'N' && $Einstellungen.newsletter.newsletter_active === 'Y'}

            {if $newsletterLeisteActive}
                {include file='snippets/newsletter.tpl'}
            {elseif $newsletterPlaceholderActive}
                {capture name="newsletterbar"}
                    {include file='snippets/newsletter.tpl' placeholder=true}
                {/capture}
            {/if}

            {capture name="socialmedia"}
                {include file='snippets/social_media.tpl'}
            {/capture}
            {if $nSeitenTyp !== $smarty.const.PAGE_WARENKORB && $nSeitenTyp !== $smarty.const.PAGE_BESTELLVORGANG}
                <footer id="footer" {if $newsletterLeisteActive}class="newsletter-active"{/if}>
                    {block name='layout-before-footer-opc'}
                        {opcMountPoint id='layout-before-footer'}
                    {/block}

                    {container class="d-print-none"}
                    {block name='layout-footer-boxes'}
                        {$findContent = ['##logo##','##social##', '##newsletter##']}
                        {$replContent = [$smarty.capture.logo, $smarty.capture.socialmedia, $smarty.capture.newsletterbar]}
                        {getBoxesByPosition position='bottom' assign='footerBoxes'}
                        {$gridFooterConfig = $Einstellungen.template.footer.grid}
                        {if $gridFooterConfig}
                            {assign var='gridFooter' value=","|explode:$gridFooterConfig}
                        {/if}
                        {if isset($footerBoxes) && count($footerBoxes) > 0}
                            {row id='footer-boxes'}
                            {foreach name='footerBoxes' from=$footerBoxes item='box'}
                                {$xl = 3}
                                {*
                                {assign var='fIndex' value=$smarty.foreach.footerBoxes.index}
                                {if isset($gridFooter.$fIndex)}
                                    {$xl = $gridFooter.$fIndex}
                                {/if}
                                *}
                                {assign var='fIndex' value=$smarty.foreach.footerBoxes.index}
                                {assign var='boxContent' value=$box->getRenderedContent()}
                                {if $boxContent}
                                    {col cols=12 sm=6 md=12 lg=3 xl=$xl}
                                        {if $fIndex == 4}
                                            <div class="d-block d-lg-none">
                                                {$boxContent|replace:$findContent:$replContent}
                                            </div>
                                        {else}
                                            {$boxContent|replace:$findContent:$replContent}
                                        {/if}
                                    {/col}
                                {/if}
                            {/foreach}
                            {/row}
                        {/if}
                    {/block}

                    {block name='layout-before-additional-opc'}
                        {opcMountPoint id='layout-before-footer-additional'}
                    {/block}

                    {if $Einstellungen.template.footer.socialmedia_footer === 'Y'}
                        {$smarty.capture.socialmedia}
                    {/if}

                        <div class="footnote-wrapper pt-3 pb-2">
                            {if $NettoPreise == 1}
                                {lang key='footnoteExclusiveVat' assign='footnoteVat'}
                            {else}
                                {lang key='footnoteInclusiveVat' assign='footnoteVat'}
                            {/if}
                            {if isset($oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND])}
                                {if $Einstellungen.global.global_versandhinweis === 'zzgl'}
                                    {lang key='footnoteExclusiveShipping' printf=$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL() assign='footnoteShipping'}
                                {elseif $Einstellungen.global.global_versandhinweis === 'inkl'}
                                    {lang key='footnoteInclusiveShipping' printf=$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL() assign='footnoteShipping'}
                                {/if}
                            {/if}
                            {block name='footer-vat-notice'}
                                <span class="footnote-vat">
                                    {assign var=isBrandFree value=JTL\Shop::isBrandfree()}
                                    {if !empty($meta_copyright)}<span itemprop="copyrightHolder">&copy; {$meta_copyright}</span>{/if}
                                    {* * {$footnoteVat}{if isset($footnoteShipping)}{$footnoteShipping}{/if}. *}
                                    {* {if $Einstellungen.global.global_zaehler_anzeigen === 'Y'}&nbsp;&bull;&nbsp; {lang key='counter'}: {$Besucherzaehler}{/if} *}
                                </span>
                            {/block}
                            {block name='shop-vendor'}
                                <span class="float-right">
                                        {* {block name='theme-vendor'}
                                            {link href="https://www.themeart.de" title="Themeart" target="_blank" rel="noopener nofollow"}Trade - JTL-Shop 5 Template{/link}&nbsp;&bull;&nbsp; 
                                        {/block}
                                        {if !$isBrandFree}
                                            Powered by {link href="https://jtl-url.de/jtlshop" title="JTL-Shop" target="_blank" rel="noopener nofollow"}JTL-Shop{/link}
                                        {/if} *}
                                        <div class="fotcredit" id="system-credits">
                                            Webdesign mit <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" class="bi bi-heart" viewBox="0 0 16 16" fill="white"> 
                                            <path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01L8 2.748zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15z"></path> 
                                          </svg>
                                          
                                            <a href="https://listandsell.de" title="List &amp; Sell" class=" text-decoration-underline" rel="noopener nofollow" target="_blank">
                                                List&amp;Sell GmbH
                                            </a>                                                                                  
                                        </div>
                                </span>
                            {/block}
                        </div>
                    {/container}

                    {block name='layout-after-footer-opc'}
                        {opcMountPoint id='layout-after-footer'}
                    {/block}

                    {block name='layout-footer-copyright'}
                        {if !empty($Einstellungen.global.global_fusszeilehinweis)}
                            <div id="copyright">
                                {container fluid=false class='pb-2'}
                                    <span>{$Einstellungen.global.global_fusszeilehinweis}</span>
                                {/container}
                            </div>
                        {/if}
                    {/block}
                    {block name='layout-footer-scroll-top'}
                        {if $Einstellungen.template.theme.button_scroll_top === 'Y'}
                            {include file='snippets/scroll_top.tpl'}
                        {/if}
                    {/block}
                </footer>
            {/if}
        {/if}
    {/block}

    {block name='layout-footer-io-path'}
        <div id="jtl-io-path" data-path="{$ShopURL}" class="d-none"></div>
    {/block}

    {* JavaScripts *}
    {block name='layout-footer-js'}
        {$dbgBarBody}
        {captchaMarkup getBody=false}
    {/block}
    {block name='layout-footer-consent-manager'}
        {if $Einstellungen.consentmanager.consent_manager_active === 'Y' && !$isAjax && $consentItems->isNotEmpty()}
            <input id="consent-manager-show-banner" type="hidden" value="{$Einstellungen.consentmanager.consent_manager_show_banner}">
            {include file='snippets/consent_manager.tpl'}
            {inline_script}
                window.CM = new ConsentManager({
                version: 1
                });
            {/inline_script}
            <script>
                setTimeout(function() {
                    $('#consent-manager, #consent-settings-btn').removeClass('d-none');
                }, 100);
                document.addEventListener('consent.updated', function(e) {
                    $.post('{$ShopURLSSL}/', {
                            'action': 'updateconsent',
                            'jtl_token': '{$smarty.session.jtl_token}',
                            'data': e.detail
                        }
                    );
                });
                {if !isset($smarty.session.consents)}
                    document.addEventListener('consent.ready', function(e) {
                        document.dispatchEvent(new CustomEvent('consent.updated', { detail: e.detail }));
                    });
                {/if}

                var trigger = $(document).find('.trigger');
                var triggerCall = function(e) {
                    e.preventDefault();
                    let type = e.target.dataset.consent;
                    if (window.CM.getSettings(type) === false) {
                        window.CM.openConfirmationModal(type, function() {
                            let data = window.CM._getLocalData();
                            if (data === null ) {
                                data = {
                                    settings: {

                                    }
                                };
                            }
                            data.settings[type] = true;
                            document.dispatchEvent(new CustomEvent('consent.updated', { detail: data.settings }));
                        });
                    }
                }
                for(let i = 0; i < trigger.length; ++i) {
                    trigger[i].addEventListener('click', triggerCall)
                }

                /* remove */
                document.addEventListener('consent.ready', function(e) {
                    embedVideoServices(e.detail);
                });
                document.addEventListener('consent.updated', function(e) {
                    embedVideoServices(e.detail);
                });

                /* remove */
                function embedVideoServices(detail) {
                    if (detail !== null && typeof detail.youtube !== 'undefined' && detail.youtube === true) {
                        let embeds = document.querySelectorAll('iframe.needs-consent.youtube');
                        for (let i = 0; i < embeds.length; ++i) {
                            embeds[i].src = embeds[i].dataset.src;
                            embeds[i].className = 'youtube';
                        }
                        let notices = document.querySelectorAll('a[data-consent="youtube"]');
                        for (let j = 0; j < notices.length; ++j) {
                            notices[j].classList.add('d-none');
                        }
                    }
                    if (detail !== null && typeof detail.vimeo !== 'undefined' && detail.vimeo === true) {
                        let embeds = document.querySelectorAll('iframe.needs-consent.vimeo');
                        for (let i = 0; i < embeds.length; ++i) {
                            embeds[i].src = embeds[i].dataset.src;
                            embeds[i].className = 'vimeo';
                        }
                        let notices = document.querySelectorAll('a[data-consent="vimeo"]');
                        for (let j = 0; j < notices.length; ++j) {
                            notices[j].classList.add('d-none');
                        }
                    }
                }
            </script>
        {/if}
    {/block}
    {* Footer mobile menu*}
    <div class="footer_mobile">
	<div class="fmenu one">
		<a href="/"> <img class="f_icon" src="/media/image/opc/ls/Home-blue.png">
			<p class="f_text">Startseite</p>
		</a>
	</div>
	<div class="fmenu two"> {block name='layout-header-logo-navbar-toggle'}
		<button id="burger-menu" class="burger-menu-wrapper navbar-toggler collapsed" type="button" data-toggle="collapse" data-target="#mainNavigation" aria-controls="mainNavigation" aria-expanded="false" aria-label="Toggle navigation"> 
        <img class="f_icon" src="/media/image/opc/ls/category-blue.png">
			<p class="f_text">Kategorien</p>
		</button> {/block} </div>
	<div class="fmenu three">
		<a href="/warenkorb"> <img class="" src="/media/image/opc/ls/cart-blue.png">
			<p class="f_text">Warenkorb</p> 
            {* <span class="fa-sup" title="{$WarenkorbArtikelPositionenanzahl}"> *}
            {* {if $WarenkorbArtikelPositionenanzahl >= 1}
                {$WarenkorbArtikelPositionenanzahl}
            {else}
                0
            {/if} *}
    </span> </a>
	</div>
	<div class="fmenu four"> {if JTL\Session\Frontend::getCustomer()->getID() === 0}
		<a class="nav-link nav-link-custom" href="/Mein-Konto" aria-label="Mein Konto"> <img class="f_icon" src="/media/image/opc/ls/profile-blue.png" alt="user" width="30" height="30">
			<p class="f_text">Anmelden</p>
		</a> {else}
		<li class="nav-item account-icon-dropdown">
			<a class="nav-link nav-link-custom" href="/Mein-Konto" aria-label="Mein Konto"> <img class="f_icon" src="/media/image/opc/ls/profile-blue.png" alt="user" width="30" height="30">
				<p class="f_text"> {lang key='myAccount'}</p>
			</a> {/if} </div>
	<div class="fmenu five">
		<a href="#" data-toggle="modal" data-target="#footer-menu-info"> <img class="f_icon" src="/media/image/opc/ls/menu-blue.png">
			<p class="f_text">Menu</p>
		</a>
	</div>
</div> {* Footer Short Menu *}
<div class="modal fade" id="footer-menu-info" tabindex="-1" role="dialog" aria-labelledby="footer-menu-info" aria-hidden="true">
	<div class="modal-dialog footer-infog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="info-title">Informationen</h4>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true">&times;</span> </button>
			</div>
			<div class="modal-body"> {if $linkgroups->getLinkGroupByTemplate('Informationen') !== null}
				<ul class="footer-info-links"> {foreach $linkgroups->getLinkGroupByTemplate('Informationen')->getLinks() as $Link}
					<li><a href="{$Link->getURL()}"><i class="fas fa-angle-right"></i> {$Link->getName()}</a></li> {/foreach} </ul> {/if} </div> {*
			<div class="modal-header">
				<h4 class="modal-title" id="info-title"> Mehr über</h4> </div> *}
			<div class="modal-body"> {if $linkgroups->getLinkGroupByTemplate('Fuss') !== null}
				<ul class="footer-info-links"> {foreach $linkgroups->getLinkGroupByTemplate('Fuss')->getLinks() as $Link}
					<li><a href="{$Link->getURL()}"><i class="fas fa-angle-right"></i> {$Link->getName()}</a></li> {/foreach} </ul> {/if} </div>
		</div>
	</div>
</div>
<div class="widget_container_overlay"></div>
<script id="trustamiwidget" type="text/javascript" src="https://cdn.trustami.com/widgetapi/widget2/trustami-widget.js" data-profile="5a03250f2b5d85ad638b45a1" data-user="2807e1e190c74b2c644307252dd71943a09ec256" data-platform="0" async></script>
{literal}
<!-- GTM QUICK LOAD -->
<script>
  (function(i,d,l,id){
    i[l]=i[l]||[];
    i[l].push({'gtm.start': new Date().getTime(), event:'gtm.js'});
    var f=d.getElementsByTagName('script')[0],
        j=d.createElement('script');
    j.async=true;
    j.src='https://www.googletagmanager.com/gtm.js?id='+id;
    f.parentNode.insertBefore(j,f);
    console.log('[GTM] injected', id);
  })(window, document, 'dataLayer', 'GTM-NNKR7376');
</script>
{/literal}
    </body>
    </html>
{/block}
