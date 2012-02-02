<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:php="http://php.net/xsl"  extension-element-prefixes="php">
<xsl:param name="get_param" /> 
<!-- контент -->
<xsl:template match="page[@type-id='10']" >
<div class="width_fix">
    <xsl:value-of select=".//property[@name = 'content']/value" disable-output-escaping="yes" />
</div>
</xsl:template>
<!-- / контент -->



<!-- новостной блок -->
<xsl:template match="page[@type-id='18'][@id='9372'] | page[@type-id='18'][@id='14284'] | page[@type-id='18'][@id='12867']" >
<!--<xsl:template match="page[@type-id='18'][@id='9372']" >-->
    <xsl:apply-templates select="document(concat('udata://news/lastlist/',@id,'/'))/udata/items/item" mode="news"/>
   <!-- <xsl:apply-templates select="document('udata://content/menu/novosti/')//item" mode="news" /> -->
</xsl:template>
<!-- /новостной блок -->
<!-- вывод новостного блока-->
	
	<xsl:template match="item" mode="news">
    <xsl:variable name="image" select="document(concat('upage://', @id))//property[@name='header_pic']/value" disable-output-escaping="yes" />
     <table>
        	<tr valign="top">
        		<td><img src="{$image}" width="100" border="0" /></td>
                <td style="vertical-align:top; padding-left:10px;">
                    <!--<a href="{@link}">-->
                        <a href="{$pre_lang}{@link}{$lite_q}">
                    <xsl:value-of select="."/>
                    </a>
                </td>
       		</tr>
      </table>
    </xsl:template>
    
    

    
    
<!-- /вывод новостного блока-->
<!-- Отдельная новость -->
<xsl:template match="page[@type-id='23']">
	<!--новость
    <xsl:value-of select="@id"/>-->
   <h1>
	<xsl:value-of select="document(concat('upage://', @id))//property[@name='h1']/value" disable-output-escaping="yes" />
   </h1>
   <xsl:variable name="image" select="document(concat('upage://', @id))//property[@name='header_pic']/value" disable-output-escaping="yes" />
   <img src="{$image}"/>
   <div id="new">
	<div class="date">
    	<xsl:variable name="dates" select="document(concat('upage://', @id))//property[@name='publish_time']/value/@unix-timestamp"/>
        <xsl:value-of select="document(concat('udata://system/convertDate/', $dates, '/(d-m-Y)'))" disable-output-escaping="yes"/>
    </div>
    <div class="content">
    	<xsl:value-of select="document(concat('upage://', @id))//property[@name='content']/value" disable-output-escaping="yes" />
    </div>
   </div>
   <!--
<div id="new">
<div class="date">
<xsl:value-of select="document(concat('udata://system/convertDate/', page/properties/group/property/value/@unix-timestamp, '/(d.m.Y)/'))/udata"/>
</div>
<div class="content">
<xsl:value-of select="page/properties/group/property[@name = 'content']/value" disable-output-escaping="yes"/>
</div>
<xsl:apply-templates select="page/properties/group[property[@name = 'source' or @name = 'source_url']]" mode="news.source"/>
</div> -->
</xsl:template>
<!-- Отдельная новость -->
<!-- результаты поиска -->

<xsl:template match="page[@type-id='10'][@id='9343'] | page[@type-id='10'][@id='12866'] | page[@type-id='10'][@id='14283']" >
    <!--<xsl:apply-templates select="document('usel://all_products2/2300/')/udata" mode="catalog_search"/>-->
    <span>&#171;<xsl:value-of select="$search_string" />&#187;</span>
    
    <xsl:if test="$lite = ''">
    <xsl:element name="script">
        <xsl:attribute name="type">text/javascript</xsl:attribute>
        <xsl:comment>
    		iArr = new Array()
        </xsl:comment>
	</xsl:element>
    </xsl:if>
    
    <xsl:variable name="tmp">
    	<xsl:value-of select="php:function('urlencode', string($search_string))" />
    </xsl:variable>
    <xsl:variable name="tmpLang">
    	<xsl:value-of select="php:function('urlencode', string($lang))" />
    </xsl:variable>
    <xsl:apply-templates select="document(concat('udata://custom/catalog_search_products/?search_string=', $tmp))/udata" mode="catalog_all"/>
   <!-- <script type="text/javascript" src="/js/showFilterForm.js"></script>-->
   <xsl:element name="script">
        <xsl:attribute name="type">text/javascript</xsl:attribute>
        <xsl:comment>
        
        	$('.add-to-cart').bind('mousedown', function(){var of = $(this).offset();mx  = of.left;my  = of.top;})
            
            if (document.getElementById("filter_form")) {
                var lis=document.getElementsByTagName("li")
                for( var i=0; i &lt; lis.length; i++)
                     if (lis[i].className=="p_c") {
                        if ($(lis[i]).find("span").filter(".bio").html() != "") {
                            document.getElementById("filter_by_bio").parentNode.style.display = "block"
                            break
                        }
                     }
                     
                if (document.getElementById("filter_by_country")) {
                    var lis=document.getElementsByTagName("li")
                    var cn3s=document.getElementById("filter_by_country").getElementsByTagName("option")

                    for( var j=1; j &lt; cn3s.length; j++) {
                        var currCn3 = cn3s[j].innerHTML
                        for( var i=0; i &lt; lis.length; i++)
                             if (lis[i].className=="p_c") {
                                if ($(lis[i]).find("span").filter(".cn3").html() == currCn3) {
                                    cn3s[j].style.display = "block"
                                    break
                                }
                             }
                    } 
                }   
  				
   
                document.getElementById("filter_form").style.display = "block"
            }

        </xsl:comment>
	</xsl:element>
    
    <xsl:if test="$lite = ''">
    <xsl:element name="script">
        <xsl:attribute name="type">text/javascript</xsl:attribute>
        <xsl:comment>
        for(var i=0;i &lt; iArr.length;i++){
                document.getElementById(iArr[i][0]).src = iArr[i][1]
            }
        </xsl:comment>
    </xsl:element>
    </xsl:if>
    
</xsl:template>
<!-- Вывод результатов поиска -->
	<!--s<xsl:key name="k1" match="udata/page" use="count(document(concat('upage://', @id))//property[@name='klubnoe_predlozhenie']/value)" />-->
<!--	<xsl:template match="udata" mode="catalog_search">
    
    	<xsl:if test="total/@club &gt; 0">
      	<br/><div style="margin-bottom:20px;margin-top:20px;" align="center" class="zag">Клубное предложение</div>
      	</xsl:if>
     
      <ul class="products">
      		<xsl:for-each select="page">
            	<xsl:sort select="name" order="ascending" data-type="text" lang="ru"/>
            	<xsl:if test="count(document(concat('upage://', @id))//property[@name='klubnoe_predlozhenie']/value) &gt; 0">
                	<xsl:apply-templates select="." mode="catalog_search"/>
                </xsl:if>
            </xsl:for-each>
      </ul>
      
      <xsl:if test="(count(key('k1',0)) &gt; 0) and (count(key('k1',1)) &gt; 0)">
      	<div style="margin-bottom:20px;" align="center"><img width="95%" height="1px" src="/i/bg/divide_line.gif"/></div>
      </xsl:if>

      <xsl:if test="count(key('k1',0)) &gt; 0">
      	<div style="margin-bottom:20px;" align="center" class="zag">Продуктовый бутик</div>
      </xsl:if>

      <ul class="products">
      		<xsl:for-each select="page">
            	<xsl:sort select="name" order="ascending" data-type="text" lang="ru"/>
            	<xsl:if test="count(document(concat('upage://', @id))//property[@name='klubnoe_predlozhenie']/value) &lt; 1">
                	<xsl:apply-templates select="." mode="catalog_search"/>
                </xsl:if>
            </xsl:for-each>-->
        	<!--<xsl:apply-templates select="page" mode="catalog_all">
            	<xsl:sort select="name" order="ascending" data-type="text" lang="ru"/>
            </xsl:apply-templates>-->
   <!--   </ul>
    <script type="text/javascript" src="/js/showFilterForm.js"></script>
    </xsl:template>-->
   <!--<xsl:template match="page" mode="catalog_search">
    	<xsl:variable name="tmp" select="@parentId" />
 <xsl:if test="not(document(concat('uobject://', $userIdVar))//property[@name=concat('no_eat_', document(concat('upage://', $tmp))//page/@alt-name)]/value/text() = '1')" >

        <xsl:variable name="shortname" select="document(concat('upage://', @id))//property[@name='shortname']/value" disable-output-escaping="yes" />
        
        <xsl:if test="contains(translate(string($shortname),'abcdefghigklmnopqrstuvwxyzабвгдеёжзиклмнопрстуфхцчшщъыьэюя','ABCDEFGHIJKLMNOPQRSTUVWXYZАБВГДЕЁЖЗИКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ'), translate(string($search_string),'abcdefghigklmnopqrstuvwxyzабвгдеёжзиклмнопрстуфхцчшщъыьэюя','ABCDEFGHIJKLMNOPQRSTUVWXYZАБВГДЕЁЖЗИКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ'))">
			<xsl:apply-templates select="." mode="product_block"/>
        </xsl:if>
    </xsl:if>    
    </xsl:template>-->
<!-- /Вывод результатов поиска -->
<!-- /результаты поиска -->
<!-- личный кабинет -->
<xsl:variable name="userIdVar" select="//user/@id" />

<xsl:template match="page[@type-id='10'][@id='4557'] | page[@type-id='10'][@id='13682'] | page[@type-id='10'][@id='12854']" >

    <xsl:element name="script">
        <xsl:attribute name="type">text/javascript</xsl:attribute>
        <xsl:comment>
    		if (is_friend() == '1') {
            	showTranslatedMsg('friend_login')
                if (document.getElementById('pre_lang_var')) var lang = document.getElementById('pre_lang_var').innerHTML 
                window.location.href = "http://www.lebongout.ru"+lang
            }
        </xsl:comment>
	</xsl:element>

    <table width="100%">
    	<tr style="width:100%">
        	<td width="33%">
            <div class="zag"><xsl:value-of select="$new_personal_data" /></div>  
            <p><span style="padding-right:5px;"><xsl:value-of select="document(concat('uobject://', /result/user/@id))//property[@name='lname']/value" /></span>
            <span style="padding-right:5px;"><xsl:value-of select="document(concat('uobject://', /result/user/@id))//property[@name='fname']/value" /></span>
            <span style="padding-right:5px;"><xsl:value-of select="document(concat('uobject://', /result/user/@id))//property[@name='father_name']/value" /></span></p>
            <p><xsl:value-of select="document(concat('uobject://', /result/user/@id))//property[@name='e-mail']/value" /><br/>
   	
            <!--<div class="zag"><xsl:value-of select="$new_personal_data" />Ваш статус</div>-->
            		<xsl:variable name="statuses" select="document(concat('uobject://', /result/user/@id))//property[@name='status']/value" disable-output-escaping="yes" />
                            <xsl:choose>
                                  <xsl:when test="$statuses = 3">
                                       <p><span style="padding-right:5px;">Статус: <strong>Gold</strong></span></p>
                                  </xsl:when>
                                  <xsl:when test="$statuses = 4">
                                       <p><span style="padding-right:5px;">Статус: <strong>Platinum</strong></span></p>
                                  </xsl:when>
                            </xsl:choose> 
            
            <xsl:value-of select="document(concat('uobject://', /result/user/@id))//property[@name='phone']/value" /><br/></p>
            <p><a href="{$pre_lang}/personal/password_change/{$lite_q}"><xsl:value-of select="$new_change_pwd" /></a><br/></p><br/>
            <xsl:value-of select="$new_inform_status" />:<br/>
                      
            <xsl:element name="input">
                    <xsl:attribute name="type">checkbox</xsl:attribute>
                    <xsl:attribute name="name">inform_via_phone</xsl:attribute>
                    <xsl:attribute name="id">inform_via_phone</xsl:attribute>
                    <xsl:attribute name="onclick">toggle_inform_via('<xsl:value-of select="//user/@login" />','<xsl:value-of select="//user/@id" />','inform_via_phone')</xsl:attribute>
                    <xsl:if test="document(concat('uobject://', /result/user/@id))//property[@name='inform_via_phone']/value = 1" >
                    	<xsl:attribute name="checked">checked</xsl:attribute>
                    </xsl:if>
                    <xsl:value-of select="$new_via_phone" />
            </xsl:element><br/>
           
            <xsl:element name="input">
                    <xsl:attribute name="type">checkbox</xsl:attribute>
                    <xsl:attribute name="name">inform_via_sms</xsl:attribute>
                    <xsl:attribute name="id">inform_via_sms</xsl:attribute>
                    <xsl:attribute name="onclick">toggle_inform_via('<xsl:value-of select="//user/@login" />','<xsl:value-of select="//user/@id" />','inform_via_sms')</xsl:attribute>
                    <xsl:if test="document(concat('uobject://', /result/user/@id))//property[@name='inform_via_sms']/value = 1" >
                    	<xsl:attribute name="checked">checked</xsl:attribute>
                    </xsl:if>
                    <xsl:value-of select="$new_via_sms" />
            </xsl:element><br/>     
 
            <xsl:element name="input">
                    <xsl:attribute name="type">checkbox</xsl:attribute>
                    <xsl:attribute name="name">inform_via_email</xsl:attribute>
                    <xsl:attribute name="id">inform_via_email</xsl:attribute>
                    <xsl:attribute name="onclick">toggle_inform_via('<xsl:value-of select="//user/@login" />','<xsl:value-of select="//user/@id" />','inform_via_email')</xsl:attribute>
                    <xsl:if test="document(concat('uobject://', /result/user/@id))//property[@name='inform_via_email']/value = 1" >
                    	<xsl:attribute name="checked">checked</xsl:attribute>
                    </xsl:if>
                    <xsl:value-of select="$new_via_email" />
            </xsl:element><br/> 
            
            <br/><br/>
			<div class="zag_click" onclick="$('#block_customer_addresses').toggle(200)"><xsl:value-of select="$new_delivery_addr" /></div>
            <div id="block_customer_addresses" style="display:none;">
                <table width="170px" cellpadding="5" cellspacing="5">
                <xsl:apply-templates select="document('udata://emarket/customerDeliveryList/')" mode="personal-adresses-list"/>
                </table>
                <!--<xsl:apply-templates select="document('udata://emarket/purchase/delivery/address/personal-list')" mode="personal-adresses-list"/>-->
                <!--<xsl:apply-templates select="document('udata://emarket/purchase')/udata" mode="personal-adresses-list"/>-->
                <!--<xsl:apply-templates select="items" mode="delivery-address" /><br/><br/>-->
                <a href="{$pre_lang}/personal/add_delivery_adderss/{$lite_q}"><xsl:value-of select="$new_add_address" /></a><br/><br/>
            </div>
            </td>
        	<td width="29%">
            <div class="zag"><xsl:value-of select="$new_your_account" /></div>
            <div class="zag"><!--<xsl:value-of select="document(concat('uobject://', $userIdVar))//property[@name='balans']/value" /> -->						
            	<xsl:choose>
                        	<xsl:when test="(count(document(concat('uobject://', $userIdVar))//property[@name='balans']/value)=0) or (document(concat('uobject://', $userIdVar))//property[@name='balans']/value = '')">
                            	0
                            </xsl:when>
                            <xsl:otherwise>
                        		<xsl:value-of select="document(concat('uobject://', $userIdVar))//property[@name='balans']/value" />
                            </xsl:otherwise>
                        </xsl:choose><xsl:text> </xsl:text><xsl:value-of select="$new_rub" />.</div>
            <a href="{$pre_lang}/personal/pay_depozit/{$lite_q}"><xsl:value-of select="$new_pay_account" /></a><br/><br/><!-- /personal/pay_deposit/ -->
            <div class="zag_click" onclick="$('#block_history').toggle(200)"><xsl:value-of select="$new_financial_history" /></div>
            <div id="block_history" style="display:block;">
            <table id="fin_history">
            <xsl:apply-templates select="document('udata://emarket/get_financial_story/')//item[position() &lt; 5]" mode="fin-history-preiew" />
            </table><br/><br/>
            <a href="{$pre_lang}/personal/full_financial_history/{$lite_q}"><xsl:value-of select="$new_all_financial_history" /></a><br/><br/>
            </div>
            </td>
        	<td width="37%" style="padding-right:5px;">
            <div class="zag"><xsl:value-of select="$new_orders_history" /></div>
             	<!-- <xsl:variable name="orderOwner" select="/result/user/@id" disable-output-escaping="yes" /> -->
                <table id="orders_history">
                <xsl:apply-templates select="document('udata://emarket/ordersList/')//item[(position() = last())or(position() = last()-1)or(position() = last()-2)]" mode="orders-history">
                	<xsl:sort select="document(concat('uobject://',@id))//property[@name = 'order_date']/value/@unix-timestamp" order="descending" />
                </xsl:apply-templates>
                </table>
            	<!--<xsl:apply-templates select="document('usel://all_orders')//item[(@ownerId=$orderOwner) and (position() &lt; 4)]" mode="orders-history" /> --> <!-- (position() &lt; 4) не работает ибо usel выдает не отсортированный и не фильтрованный по ownerId результат  -->
                <br/><br/>
    			<a href="{$pre_lang}/personal/all_orders_history/{$lite_q}"><xsl:value-of select="$new_all_orders_history" /></a><br/><br/>
            <div class="zag_click" onclick="$('#block_order_templates').toggle(200)"><xsl:value-of select="$new_order_tpls" /></div>
            <div id="block_order_templates" style="display:none;">
            	<table id="favorite_orders">
                <xsl:apply-templates select="document('udata://emarket/ordersList/')//item" mode="favorite-orders" />
                </table>
            </div>
            </td>
        </tr>
    </table>
    
    <div class="zag_click" onclick="$('#block_food_pref').toggle(200)"><xsl:value-of select="$new_not_eat" /></div>
    <div id="block_food_pref" style="display:none;">
    <xsl:value-of select="$new_not_eat_comment" /><br/><br/>
    <form id="food_preferences" method="post" action="{$pre_lang}/users/save_food_preferences/">
                <ul style="float:left;">
                <!--<xsl:apply-templates select="document('udata://content/menu/notemplate/0/2300/')/udata//item" mode="genereate-food-prefer-checkboxes" />-->                                 
                	<xsl:apply-templates select="document('udata://custom/catalog_menu_lite/?root=2300')/udata//item" mode="genereate-food-prefer-checkboxes" />
                </ul>
                <xsl:element name="input">
                    <xsl:attribute name="value"><xsl:value-of select="//user/@id" /></xsl:attribute>
                    <xsl:attribute name="type">hidden</xsl:attribute>
                    <xsl:attribute name="name">user_id</xsl:attribute>
                </xsl:element>
                <xsl:element name="input">
                    <xsl:attribute name="value"><xsl:value-of select="//user/@login" /></xsl:attribute>
                    <xsl:attribute name="type">hidden</xsl:attribute>
                    <xsl:attribute name="name">user_login</xsl:attribute>
                </xsl:element>
                <br/><br/>
         <!--<div style="padding-top:20px;"><input type="submit" value="Сохранить изменения" /></div>-->
         <img alt="Сохранить" style="cursor:pointer" onclick="this.parentNode.submit()" src="/i/bg{$pre_lang}/save.png" />
         <br/>
    </form>
    <br></br>
    </div>
    <!-- Электронный договор -->
   <!-- <p><a href="{$pre_lang}/personal/dogovor/{$lite_q}"><xsl:value-of select="$new_dogovor" /></a></p>-->
    <!-- /Электронный договор -->
    <!-- Управление рассылками -->
   	<div class="zag_click" onclick="$('#block_ruseller').toggle(200)"><xsl:value-of select="$new_ruseller_name" /></div>
    <div id="block_ruseller" style="display:none;">
    <xsl:value-of select="$new_ruseller_comment" /><br/><br/>
          Рассылки
    </div>
    <!-- /Управление рассылками -->
    <!--<div class="zag"><xsl:value-of select="$new_invite_friend" /></div>-->
    <p><a href="{$pre_lang}/personal/otpravit_priglashenie_drugu/{$lite_q}"><xsl:value-of select="$new_invite_friend" /></a></p>
    <!--<a href="javascript:test2();">*</a>-->
</xsl:template>
<!-- / личный кабинет  -->
<xsl:template match="property" mode="personal-data">
	<xsl:value-of select="value" />
</xsl:template>
<!-- Вывод чекбоксов НЕ ЕМ по категориям  -->
<xsl:template match="item" mode="genereate-food-prefer-checkboxes">
    <li style="float:left; width:160px; padding-bottom:15px;">
        <!--<xsl:variable name="cbVal" select="/result/user/@id" disable-output-escaping="yes" />-->
         <xsl:variable name="cbName" select="concat('no_eat_all_' ,@alt_name)" />
         <xsl:element name="input">
            <xsl:attribute name="type">checkbox</xsl:attribute>
            <xsl:attribute name="onclick">var childUL = document.getElementById('categorys_<xsl:value-of select="@alt_name" />'); for(var i=0; i&lt;childUL.childNodes.length; i++) childUL.childNodes.item(i).childNodes.item(0).checked=this.checked</xsl:attribute>
            <xsl:attribute name="name">no_eat_all_<xsl:value-of select="@alt_name" /> 
             </xsl:attribute>
             <xsl:attribute name="id">no_eat_all_<xsl:value-of select="@alt_name" /></xsl:attribute>
           <xsl:if test="document(concat('uobject://', $userIdVar))//property[@name=$cbName]/value = 1" >
                <xsl:attribute name="checked">checked</xsl:attribute>
            </xsl:if>
            
           <!-- <xsl:value-of select="@name" />-->
           <xsl:choose>
                <xsl:when test="$pre_lang = '/fr'">
                    <xsl:value-of select="@name_fr"  disable-output-escaping="yes"  />
                </xsl:when>
                <xsl:when test="$pre_lang = '/en'">
                    <xsl:value-of select="@name_eng"  disable-output-escaping="yes"  />
                </xsl:when>
                <xsl:otherwise>
                   <xsl:value-of select="@name"  disable-output-escaping="yes"  />
                </xsl:otherwise>
            </xsl:choose>
            
         </xsl:element>
         <xsl:element name="ul">
         	<xsl:attribute name="style">margin-left:15px;</xsl:attribute>
            <xsl:attribute name="id">categorys_<xsl:value-of select="@alt_name" /></xsl:attribute>
            <!--<xsl:apply-templates select="document(concat('udata://catalog/getCategoryList/notemplate/',@id,'/10'))/udata/items/item" mode="not-eat-subcat"/>-->
            <xsl:apply-templates select="document(concat('udata://custom/catalog_menu_lite/?root=',@id))/udata/items/item" mode="not-eat-subcat"/>
         </xsl:element> 
    </li>
</xsl:template>
<!-- / Вывод чекбоксов НЕ ЕМ по категориям  -->
<!-- Вывод чекбоксов НЕ ЕМ внути категории  -->
<xsl:template match="item" mode="not-eat-subcat">
    <li style="float:left; width:145px;">
        <!--<xsl:variable name="cbVal" select="/result/user/@id" disable-output-escaping="yes" />-->
        <xsl:variable name="cbName" select="concat('no_eat_' ,@alt_name)" />
         <xsl:element name="input">
            <xsl:attribute name="type">checkbox</xsl:attribute>
            <xsl:attribute name="name">no_eat_<xsl:value-of select="@alt_name" />  </xsl:attribute>
            <xsl:attribute name="onclick">var chCount = 0;var parentUL = this.parentNode;parentUL=parentUL.parentNode;  for(var i=0; i&lt;parentUL.childNodes.length; i++) if (parentUL.childNodes.item(i).childNodes.item(0).checked!='')chCount++; if (chCount == parentUL.childNodes.length) {var sname=parentUL.id.replace('categorys_', 'no_eat_all_');  var el2=document.getElementById(sname); if (el2) el2.checked='checked'} else {var sname=parentUL.id.replace('categorys_', 'no_eat_all_');var el2= document.getElementById(sname); if(el2) el2.checked=''}</xsl:attribute>
            <!--<xsl:attribute name="id"><xsl:value-of select="document(concat('upage://',@id))/udata/page/@alt-name" /></xsl:attribute>-->
           <xsl:if test="document(concat('uobject://', $userIdVar))//property[@name=$cbName]/value = 1" >
                <xsl:attribute name="checked">checked</xsl:attribute>
           </xsl:if>
            
           <!--<xsl:value-of select="text()" />-->
           <!--<xsl:value-of select="@name" />-->
           <xsl:choose>
                <xsl:when test="$pre_lang = '/fr'">
                    <xsl:value-of select="@name_fr"  disable-output-escaping="yes"  />
                </xsl:when>
                <xsl:when test="$pre_lang = '/en'">
                    <xsl:value-of select="@name_eng"  disable-output-escaping="yes"  />
                </xsl:when>
                <xsl:otherwise>
                   <xsl:value-of select="@name"  disable-output-escaping="yes"  />
                </xsl:otherwise>
            </xsl:choose>
         </xsl:element>
    </li>
</xsl:template>
<!-- / Вывод чекбоксов НЕ ЕМ внути категории  -->

<!-- Финансовая история -->
<xsl:template match="item" mode="fin-history-preiew">
	<tr height="15px">
    	<td width="60px">
        	<xsl:value-of select="document(concat('udata://custom/dateru/', payment_date/@unix-timestamp))" />
        </td>
        <td>
        	<a href="{$pre_lang}/personal/deposit_info/?deposit_id={@id}{$lite_a}"><xsl:value-of select="summa" /><xsl:text> </xsl:text><xsl:value-of select="$new_rub" />.</a>
        </td>
    </tr>
</xsl:template>
<!-- / Финансовая история -->

<!-- избранные заказы -->
<xsl:template match="item" mode="favorite-orders">
    <xsl:if test="document(concat('uobject://',@id))//property[@name='is_favorite']/value = 1" >
        <tr>
           <!-- <xsl:apply-templates select="document(concat('uobject://',@id))//property[@name='favorite_name']" mode="favorite-orders" />-->
           <td width="150px" valign="middle" height="30px">
            	<a href="javascript:add_favorit_order_to_cart('{@id}');"> <xsl:value-of select="document(concat('uobject://',@id))//property[@name='favorite_name']/value" /> </a>
        	</td>
        </tr>
    </xsl:if>
</xsl:template>

<!--<xsl:template match="property" mode="favorite-orders">
	<xsl:if test="attribute::name = 'favorite_name'" >
        <td width="150px" valign="middle" height="30px">
            <a href="javascript:add_favorit_order_to_cart('{ancestor::object/@id}');"> <xsl:value-of select="value" /> </a>
        </td>
     </xsl:if>
</xsl:template>-->

<!-- / избранные заказы -->
<!-- история заказов self::property[@name='order_date']/value-->
<xsl:template match="item" mode="orders-history">
    <tr>
        <xsl:apply-templates select="document(concat('uobject://',@id))//property" mode="orders-preview" />
    </tr>
</xsl:template>

<xsl:template match="property" mode="orders-preview">
  <!-- <xsl:if test="attribute::name = 'order_date'" >
    <td width="170px">
        <xsl:value-of select="value" />
    </td>
    </xsl:if>
    <xsl:if test="attribute::name = 'number'" >
    <td>
        <xsl:element name="a">
            <xsl:attribute name="href">/udata://emarket/order/<xsl:value-of select="ancestor::object/@id" /></xsl:attribute>
            <xsl:value-of select="value" />
        </xsl:element>
        <br/>
     </td>   
     </xsl:if> -->
     
    <xsl:if test="attribute::name = 'order_date'" >
        <td width="61px">
            <!--<xsl:value-of select="value" />-->
            <xsl:value-of select="document(concat('udata://custom/dateru/', value/@unix-timestamp))" />
        </td>
        <td  width="98px">
        <xsl:element name="a">
        	<xsl:attribute name="href"><xsl:value-of select="$pre_lang" />/personal/order_info?order_id=<xsl:value-of select="ancestor::object/@id" /><xsl:value-of select="$lite_a" /></xsl:attribute>
            <!--<xsl:attribute name="href">/udata://emarket/order/<xsl:value-of select="ancestor::object/@id" /></xsl:attribute>-->
        	<xsl:value-of select="$new_order" /><xsl:text> </xsl:text><xsl:value-of select="preceding-sibling::property[@name = 'number']//value" /><!--<xsl:value-of select="ancestor::object/@name" />-->
        </xsl:element>
        </td>
        <td>
        	<xsl:text> </xsl:text><!--<xsl:value-of select="preceding-sibling::property[@name = 'status_id']/value/item/@name" />-->
            <xsl:choose>
                <xsl:when test="$pre_lang = '/fr'">
                    <xsl:value-of select="document(concat('uobject://', preceding-sibling::property[@name = 'status_id']/value/item/@id))//property[@name='name_fr']/value" />
                </xsl:when>
                <xsl:when test="$pre_lang = '/en'">
                    <xsl:value-of select="document(concat('uobject://', preceding-sibling::property[@name = 'status_id']/value/item/@id))//property[@name='name_eng']/value" />
                </xsl:when>
                <xsl:otherwise>
                   <xsl:value-of select="preceding-sibling::property[@name = 'status_id']/value/item/@name" />
                </xsl:otherwise>
            </xsl:choose>
        </td>
     </xsl:if>
      <!--
     <td>
     <xsl:value-of select="self::property[@name='order_date']/value" />
     </td>
     <td>
     <xsl:value-of select="self::property[@name='number']/value" />
     </td>-->
</xsl:template>
<!-- / история заказов self::property[@name='order_date']/-->
<!-- список адресов -->


<xsl:template match="item" mode="personal-adresses-list">
    <tr>
        <td>
        	<div class="form_element">
                <xsl:apply-templates select="document(concat('uobject://', @id))//property" mode="personal-adresses-list" />
                <br/><br/>
            </div>
        </td>
    	<td style="vertical-align:middle;padding-left:5px;">
        	<!--<form method="post" action="{$pre_lang}/emarket/purchase/delivery/address/personal-del/">-->
            <form method="post" action="{$pre_lang}/emarket/delivery_del/">
            	<xsl:apply-templates select="document(concat('uobject://', @id))//object/@id" mode="personal-adresses-id" />
        		<img src="/images/cms/field_delete.png" alt="удалить" onclick="this.parentNode.submit()" style="cursor:pointer;"/>
            </form>
        </td>
    </tr>
</xsl:template>

<!-- ID объекта-адреса для удаления -->
<xsl:template match="object/@id" mode="personal-adresses-id">
        <xsl:element name="input">
            <xsl:attribute name="type">hidden</xsl:attribute>
            <xsl:attribute name="name">address_id</xsl:attribute>
            <xsl:attribute name="value">
            	<xsl:apply-templates />
            </xsl:attribute>
        </xsl:element>
</xsl:template>
<!-- / ID объекта-адреса для удаления -->

<xsl:template match="property" mode="personal-adresses-list">
    <xsl:if test="title[text()='Страна']" >
    </xsl:if>
    <xsl:if test="attribute::name='index'" >
       <!-- <xsl:text> </xsl:text>
    	<xsl:value-of select="value" />
        <xsl:text> </xsl:text>-->
    </xsl:if>
    <xsl:if test="attribute::name='region'" >
       <!-- <xsl:text> </xsl:text>
    	<xsl:value-of select="value" />
        <xsl:text> </xsl:text>-->
    </xsl:if>
    <xsl:if test="attribute::name='city'" >
    	<xsl:value-of select="$new_city" /><xsl:text> </xsl:text>
    	<xsl:value-of select="value" />
        <xsl:text> </xsl:text>
    </xsl:if> 
    <xsl:if test="attribute::name='street'" >
    	<xsl:value-of select="$new_street" /><xsl:text> </xsl:text>
    	<xsl:value-of select="value" />
        <xsl:text> </xsl:text>
    </xsl:if>
    <xsl:if test="attribute::name='house'" >
    	<xsl:value-of select="$new_house" /><xsl:text> </xsl:text>
    	<xsl:value-of select="value" />
        <xsl:text> </xsl:text>
    </xsl:if>
    <xsl:if test="attribute::name='flat'" >
    	<xsl:value-of select="$new_flat" /><xsl:text> </xsl:text>
    	<xsl:value-of select="value" />
        <xsl:text> </xsl:text>
    </xsl:if>
</xsl:template>
<!-- / список адресов -->
<!-- добавить адрес доставки -->
<xsl:template match="page[@type-id='10'][@id='4564'] | page[@type-id='10'][@id='12855'] | page[@type-id='10'][@id='13683']" >

	<xsl:element name="script">
        <xsl:attribute name="type">text/javascript</xsl:attribute>
        <xsl:comment>
    		if (is_friend() == '1') {
            	showTranslatedMsg('friend_login')
                if (document.getElementById('pre_lang_var')) var lang = document.getElementById('pre_lang_var').innerHTML 
                window.location.href = "http://www.lebongout.ru"+lang
            }
        </xsl:comment>
	</xsl:element>

<!--<form id="delivery_address" method="post" action="{$pre_lang}/emarket/purchase/delivery/address/do/">-->
	<form id="delivery_address" method="post" action="{$pre_lang}/emarket/delivery_add_do/">
        <xsl:apply-templates select="document('udata://data/getCreateForm/803')//field" mode="add-address-form" />
        <br/>
            <!--<input type="hidden" name="from-personal-cabinet" id="from-personal-cabinet" value="personal-cabinet" />-->
        <input type="hidden" name="delivery-address" id="delivery-address" value="new" />
        <img alt="Сохранить" style="cursor:pointer" onclick="this.parentNode.submit()" src="/i/bg{$pre_lang}/save.png" />
			
	</form>

</xsl:template>

	<xsl:template match="field" mode="add-address-form">
		<xsl:choose>
            <xsl:when test="(@name = 'country')">
				<div style="display:none;">
                        <select type="text" name="{@input_name}">
                            <option value="26341" selected="selected">Россия</option>
                        </select>
                </div>
            </xsl:when>
            <xsl:when test="(@name = 'index')or(@name = 'region')">
				<div style="display:none;">
                    <input type="text" name="{@input_name}" value="" />
                </div>
            </xsl:when>
            <xsl:when test="@name = 'city'">
				<div>
                	<div class="sfa_delivery">
                        <xsl:variable name="new_title_city">
                            <xsl:choose>
                                <xsl:when test="($pre_lang = '/') or ($pre_lang = '')">
                                    <xsl:value-of select="@title" disable-output-escaping="yes" />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="$new_addr_city" disable-output-escaping="yes" />
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                    
                        <xsl:value-of select="concat($new_title_city, ':')" />
                    </div>
                       <!-- <input type="text" name="{@input_name}" value="Москва" class="textinputs" /> -->
                       <select name="{@input_name}" class="textinputs">
                            <option value="Балашиха">Балашиха</option>
                            <option value="Видное">Видное</option>
                            <option value="Дзержинский">Дзержинский</option>
                            <option value="Долгопрудный">Долгопрудный</option>
                            <option value="Котельники">Котельники</option>
                            <option value="Красногорск">Красногорск</option>
                            <option value="Люберцы">Люберцы</option>
                            <option value="Москва" selected="selected">Москва</option>
                            <option value="Реутов">Реутов</option>
                            <option value="Химки">Химки</option>
                            <option value="Щербинка">Щербинка</option>
                        </select>
                </div>
            </xsl:when>
            <xsl:otherwise>
            
            <xsl:variable name="new_title">
                <xsl:choose>
                    <xsl:when test="$pre_lang = '/fr'">
                        <xsl:choose>
                        	<xsl:when test="@title = 'Город'">
                                <xsl:value-of select="$new_addr_city" disable-output-escaping="yes" />
                            </xsl:when>
                            <xsl:when test="@title = 'Дом'">
                                <xsl:value-of select="$new_addr_house" disable-output-escaping="yes" />
                            </xsl:when>
                            <xsl:when test="@title = 'Квартира'">
                                <xsl:value-of select="$new_addr_flat" disable-output-escaping="yes" />
                            </xsl:when>
                            <xsl:when test="@title = 'Улица'">
                                <xsl:value-of select="$new_addr_street" disable-output-escaping="yes" />
                            </xsl:when>
                            <xsl:when test="@title = 'Комментарий'">
                                <xsl:value-of select="$new_addr_comment" disable-output-escaping="yes" />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="@title" disable-output-escaping="yes" />
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:when test="$pre_lang = '/en'">
                        <xsl:choose>
                        	<xsl:when test="@title = 'Город'">
                                <xsl:value-of select="$new_addr_city" disable-output-escaping="yes" />
                            </xsl:when>
                            <xsl:when test="@title = 'Дом'">
                                <xsl:value-of select="$new_addr_house" disable-output-escaping="yes" />
                            </xsl:when>
                            <xsl:when test="@title = 'Квартира'">
                                <xsl:value-of select="$new_addr_flat" disable-output-escaping="yes" />
                            </xsl:when>
                            <xsl:when test="@title = 'Улица'">
                                <xsl:value-of select="$new_addr_street" disable-output-escaping="yes" />
                            </xsl:when>
                            <xsl:when test="@title = 'Комментарий'">
                                <xsl:value-of select="$new_addr_comment" disable-output-escaping="yes" />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="@title" disable-output-escaping="yes" />
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                       <xsl:value-of select="@title" disable-output-escaping="yes" />
                    </xsl:otherwise>
                </xsl:choose>
                </xsl:variable>
            
                <div>
                    <div class="sfa_delivery">
                        <xsl:value-of select="concat($new_title, ':')" />
                    </div>
                    <input type="text" name="{@input_name}" value="{.}" class="textinputs" />
                </div>            
            </xsl:otherwise>
         </xsl:choose>
	</xsl:template>

<!-- / добавить адрес доставки -->
<!-- вся история заказов -->
<xsl:template match="page[@type-id='10'][@id='4586'] | page[@type-id='10'][@id='13684'] | page[@type-id='10'][@id='12856']" >

	<xsl:element name="script">
        <xsl:attribute name="type">text/javascript</xsl:attribute>
        <xsl:comment>
    		if (is_friend() == '1') {
            	showTranslatedMsg('friend_login')
                if (document.getElementById('pre_lang_var')) var lang = document.getElementById('pre_lang_var').innerHTML 
                window.location.href = "http://www.lebongout.ru"+lang
            }
        </xsl:comment>
	</xsl:element>

<table id="orders_history">
    <xsl:apply-templates select="document('udata://emarket/ordersList/')//item" mode="orders-all-history" />
</table>
</xsl:template>

<xsl:template match="item" mode="orders-all-history">
<tr>
	<xsl:apply-templates select="document(concat('uobject://',@id))//property" mode="orders-all-history" />
</tr>
</xsl:template>

<xsl:template match="property" mode="orders-all-history">
    <xsl:if test="attribute::name = 'order_date'" >
        <td width="110px">
            <!--<xsl:value-of select="value" />-->
            <xsl:value-of select="document(concat('udata://custom/dateru/', value/@unix-timestamp))" />
        </td>
        <td width="125px">
        <xsl:element name="a">
            <!--<xsl:attribute name="href">/udata://emarket/order/<xsl:value-of select="ancestor::object/@id" /></xsl:attribute>-->
            <xsl:attribute name="href"><xsl:value-of select="$pre_lang" />/personal/order_info?order_id=<xsl:value-of select="ancestor::object/@id" /><xsl:value-of select="$lite_a" /> </xsl:attribute>
        	<xsl:value-of select="$new_order" /><xsl:text> </xsl:text><xsl:value-of select="preceding-sibling::property[@name = 'number']//value" /><!--<xsl:value-of select="ancestor::object/@name" />-->
        </xsl:element>
        </td>
        <td width="125px">
        	<xsl:text> </xsl:text><!--<xsl:value-of select="preceding-sibling::property[@name = 'status_id']/value/item/@name" />-->
            <xsl:choose>
                <xsl:when test="$pre_lang = '/fr'">
                    <xsl:value-of select="document(concat('uobject://', preceding-sibling::property[@name = 'status_id']/value/item/@id))//property[@name='name_fr']/value" />
                </xsl:when>
                <xsl:when test="$pre_lang = '/en'">
                    <xsl:value-of select="document(concat('uobject://', preceding-sibling::property[@name = 'status_id']/value/item/@id))//property[@name='name_eng']/value" />
                </xsl:when>
                <xsl:otherwise>
                   <xsl:value-of select="preceding-sibling::property[@name = 'status_id']/value/item/@name" />
                </xsl:otherwise>
            </xsl:choose>
        </td>
        <td width="35px">
        	<xsl:if test="document(concat('uobject://', preceding-sibling::property[@name = 'status_id']/value/item/@id))//property[@name='codename']/value = 'waiting'">
                <xsl:element name="a">
                    <xsl:attribute name="href"><xsl:value-of select="$pre_lang" />/emarket/quit_order/?order_id=<xsl:value-of select="ancestor::object/@id" /><xsl:value-of select="$lite_a" /></xsl:attribute>
                    <img src="/images/cms/field_delete.png" alt="Отменить заказ" />
                </xsl:element>
            </xsl:if>
        </td>
        <td>
        <xsl:choose>
        	<xsl:when test="ancestor::object//group[@name = 'favorite_props']//property[@name='is_favorite']/value = '1'">
            	<xsl:value-of select="ancestor::object//group[@name = 'favorite_props']//property[@name='favorite_name']/value"/>
            </xsl:when>
            <xsl:otherwise>
            	<xsl:element name="a">
                    <xsl:attribute name="href"><xsl:value-of select="$pre_lang" />/personal/save_as_template/?order_id=<xsl:value-of select="ancestor::object/@id" /><xsl:value-of select="$lite_a" /></xsl:attribute>
                    <xsl:value-of select="$new_save_tpl" />
            	</xsl:element>
            </xsl:otherwise>
        </xsl:choose>
		</td>
     </xsl:if>
</xsl:template>
<!-- / вся история заказов -->
<!-- информация о заказе -->
<xsl:param name="order_id" /> 

<xsl:template match="page[@type-id='10'][@id='4587'] | page[@type-id='10'][@id='12857'] | page[@type-id='10'][@id='13685']" >

	<xsl:element name="script">
        <xsl:attribute name="type">text/javascript</xsl:attribute>
        <xsl:comment>
    		if (is_friend() == '1') {
            	showTranslatedMsg('friend_login')
                if (document.getElementById('pre_lang_var')) var lang = document.getElementById('pre_lang_var').innerHTML 
                window.location.href = "http://www.lebongout.ru"+lang
            }
        </xsl:comment>
	</xsl:element>
    
	<!--<xsl:apply-templates select="document(concat('udata://emarket/order',$order_id))//property" mode="single-order-info" />-->
    <table id="table_order_info">
    <tr>
    	<td>
        	<b><xsl:value-of select="$new_nomination" /></b>
        </td>
        <td>
        	<b><xsl:value-of select="$new_amount" /></b>
        </td>
        <td>
        	<b><xsl:value-of select="$new_price_one" /></b>
        </td>
        <td>
        	<b><xsl:value-of select="$new_total" /></b>
        </td>
    </tr>
    <xsl:apply-templates select="document(concat('udata://emarket/order/',$order_id))//items/item" mode="single-order-info" />
	</table>
    <br/><br/>
    <!--Всего позиций: <xsl:apply-templates select="document(concat('udata://emarket/order/',$order_id))//number" /><br/>-->
    <xsl:value-of select="$new_price_one" />: <xsl:apply-templates select="document(concat('udata://emarket/order/',$order_id))//summary/price" mode="single-order-info-summ" />
    <br/><br/><br/>
    
    <xsl:variable name="status_tmp" select="document(concat('uobject://', $order_id))//property[@name='status_id']/value/item/@id" />
    
    <xsl:if test="document(concat('uobject://', $status_tmp))//property[@name='codename']/value = 'waiting'">
                <xsl:element name="a">
                    <xsl:attribute name="href"><xsl:value-of select="$pre_lang" />/emarket/quit_order/?order_id=<xsl:value-of select="$order_id" /><xsl:value-of select="$lite_a" /></xsl:attribute>
                    <img src="/i/bg{$pre_lang}/quitorder.png" alt="Отменить заказ" />
                </xsl:element>
           </xsl:if> 
           <xsl:text>  </xsl:text>
    <xsl:if test="not(document(concat('uobject://', $order_id))//property[@name='is_favorite']/value = 1)">    
           <a href="{$pre_lang}/personal/save_as_template/?order_id={$order_id}{$lite_a}"><img alt="Сохранить в шаблоны" style="cursor:pointer" src="/i/bg{$pre_lang}/save.png" /></a>
    </xsl:if>
</xsl:template>

<xsl:template match="price" mode="single-order-info-summ">
<xsl:variable name="tmp_suffix">
    <xsl:choose>
        <xsl:when test="$pre_lang = '/fr'">
            <xsl:choose>
                <xsl:when test="@suffix = 'руб'">
                    <xsl:value-of select="$new_rub" disable-output-escaping="yes" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="@suffix" disable-output-escaping="yes" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:when>
        <xsl:when test="$pre_lang = '/en'">
            <xsl:choose>
                <xsl:when test="@suffix = 'руб'">
                    <xsl:value-of select="$new_rub" disable-output-escaping="yes" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="@suffix" disable-output-escaping="yes" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
           <xsl:value-of select="@suffix"  disable-output-escaping="yes"  />
        </xsl:otherwise>
    </xsl:choose>
</xsl:variable>


	<xsl:value-of select="actual" /> (<xsl:value-of select="$tmp_suffix" />)
</xsl:template>

<xsl:template match="item" mode="single-order-info">
<xsl:variable name="page_tmp" select="document(concat('uobject://',@id))//page/@id" />
<xsl:variable name="ei_tmp" select="document(concat('upage://',$page_tmp))//property[@name = 'unit']/value" />

<xsl:variable name="new_prod_units">
	<xsl:choose>
        <xsl:when test="$pre_lang = '/fr'">
            <xsl:choose>
                <xsl:when test="$ei_tmp = 'шт'">
                    <xsl:value-of select="$new_thing" disable-output-escaping="yes" />
                </xsl:when>
                <xsl:when test="$ei_tmp = 'кг'">
                    <xsl:value-of select="$new_kg" disable-output-escaping="yes" />
                </xsl:when>
                <xsl:when test="$ei_tmp = 'упак'">
                    <xsl:value-of select="$new_pack" disable-output-escaping="yes" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$ei_tmp" disable-output-escaping="yes" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:when>
        <xsl:when test="$pre_lang = '/en'">
            <xsl:choose>
                <xsl:when test="$ei_tmp = 'шт'">
                    <xsl:value-of select="$new_thing" disable-output-escaping="yes" />
                </xsl:when>
                <xsl:when test="$ei_tmp = 'кг'">
                    <xsl:value-of select="$new_kg" disable-output-escaping="yes" />
                </xsl:when>
                <xsl:when test="$ei_tmp = 'упак'">
                    <xsl:value-of select="$new_pack" disable-output-escaping="yes" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$ei_tmp" disable-output-escaping="yes" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
           <xsl:value-of select="$ei_tmp" disable-output-escaping="yes" />
        </xsl:otherwise>
    </xsl:choose>
</xsl:variable>

<xsl:variable name="tmp_suffix">
<xsl:choose>
    <xsl:when test="$pre_lang = '/fr'">
        <xsl:choose>
            <xsl:when test="price/@suffix = 'руб'">
                <xsl:value-of select="$new_rub" disable-output-escaping="yes" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="price/@suffix" disable-output-escaping="yes" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:when>
    <xsl:when test="$pre_lang = '/en'">
        <xsl:choose>
            <xsl:when test="price/@suffix = 'руб'">
                <xsl:value-of select="$new_rub" disable-output-escaping="yes" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="price/@suffix" disable-output-escaping="yes" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
       <xsl:value-of select="price/@suffix"  disable-output-escaping="yes"  />
    </xsl:otherwise>
</xsl:choose>
</xsl:variable>

<tr>
    <td width="390px"> 
        <xsl:choose>
            <xsl:when test="$pre_lang = '/fr'">
                <xsl:value-of select="document(concat('upage://',$page_tmp))//property[@name = 'shortname_fr']/value"  disable-output-escaping="yes" />
            </xsl:when>
            <xsl:when test="$pre_lang = '/en'">
                <xsl:value-of select="document(concat('upage://',$page_tmp))//property[@name = 'shortname_en']/value"  disable-output-escaping="yes" />
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="@name"  disable-output-escaping="yes"  />
            </xsl:otherwise>
        </xsl:choose>
    </td>
    <td width="70px"><xsl:value-of select="amount" /></td>
    <xsl:choose>
    	<xsl:when test="$ei_tmp = 'кг'" >
        	<td width="90px"><xsl:value-of select="price/actual * amount" /> (<xsl:value-of select="$tmp_suffix" />/<xsl:value-of  select="$new_prod_units" />)</td>
        </xsl:when>
        <xsl:otherwise>
        	<td width="90px"><xsl:value-of select="price/actual" /> (<xsl:value-of select="$tmp_suffix" />/<xsl:value-of select="$new_prod_units" />)</td>
        </xsl:otherwise>
    </xsl:choose>
    <td width="90px"><xsl:value-of select="total-price/actual" /> (<xsl:value-of select="$tmp_suffix" />)</td>
</tr>
</xsl:template>
<!-- / информация о заказе -->
<!-- Информация о депозите -->
<xsl:param name="deposit_id" /> 

<xsl:template match="page[@type-id='10'][@id='11106'] | page[@type-id='10'][@id='13692'] | page[@type-id='10'][@id='12864']" >
	
    <xsl:element name="script">
        <xsl:attribute name="type">text/javascript</xsl:attribute>
        <xsl:comment>
    		if (is_friend() == '1') {
            	showTranslatedMsg('friend_login')
                if (document.getElementById('pre_lang_var')) var lang = document.getElementById('pre_lang_var').innerHTML 
                window.location.href = "http://www.lebongout.ru"+lang
            }
        </xsl:comment>
	</xsl:element>

	<xsl:apply-templates select="document(concat('udata://emarket/deposit/?deposit_id=', $deposit_id))" mode="deposit-info"/>
</xsl:template>

<xsl:template match="udata" mode="deposit-info" >
	<xsl:value-of select="$new_number" />: <xsl:value-of  select="number"/> <br/>
    <xsl:value-of select="$new_date" />: <xsl:value-of  select="payment-date"/> <br/>
    <xsl:value-of select="$new_transaction_number" />: <xsl:value-of  select="payment-document-num"/> <br/>
    <xsl:value-of select="$new_sum" />: <xsl:value-of  select="total-price"/><xsl:text> </xsl:text><xsl:value-of select="$new_rub" />.<br/>
    Тип: <xsl:value-of  select="type"/><br/>
</xsl:template>
<!-- / Информация о депозите -->

<!-- смена пароля -->
<xsl:param name="_err" />

<xsl:template match="page[@type-id='10'][@id='4588'] | page[@type-id='10'][@id='12858'] | page[@type-id='10'][@id='13686']" >

	<xsl:element name="script">
        <xsl:attribute name="type">text/javascript</xsl:attribute>
        <xsl:comment>
    		if (is_friend() == '1') {
            	showTranslatedMsg('friend_login')
                if (document.getElementById('pre_lang_var')) var lang = document.getElementById('pre_lang_var').innerHTML 
                window.location.href = "http://www.lebongout.ru"+lang
            }
        </xsl:comment>
	</xsl:element>

<b><xsl:value-of select="$new_attention"/></b><br/>
<xsl:element name="span">
	<xsl:if test="$_err = 'pwd_equals_login'">
    	<xsl:attribute name="style">
        	color:#ff0000;
        </xsl:attribute>
    </xsl:if>
	<div> - <xsl:value-of select="$new_msg_pwd_equal_login"/></div>
</xsl:element>
<xsl:element name="span">
	<xsl:if test="$_err = 'too_short_pwd'">
    	<xsl:attribute name="style">
        	color:#ff0000;
        </xsl:attribute>
    </xsl:if>
	<div> - <xsl:value-of select="$new_msg_pwd_too_short"/></div>
</xsl:element>
<xsl:element name="span">
	<xsl:if test="$_err = 'pwd_notequals_confirm'">
    	<xsl:attribute name="style">
        	color:#ff0000;
        </xsl:attribute>
    </xsl:if>
	<div> - <xsl:value-of select="$new_msg_pwd_check_prove"/></div>
</xsl:element>
<br/>
<br/>

<form id="password_change" method="post" action="{$pre_lang}/users/change_pass/">
<div class="formInputDiv">
    <xsl:value-of select="$new_new_pwd"/>: <input type="password" name="new_pass" id="new_pass" value="" /><br/>
</div>
<div class="formInputDiv">
    <xsl:value-of select="$new_confirm"/>: <input type="password" name="confirm_pass" id="confirm_pass" value="" /><br/>
</div>
	<xsl:element name="input">
        <xsl:attribute name="value"><xsl:value-of select="//user/@id" /></xsl:attribute>
        <xsl:attribute name="type">hidden</xsl:attribute>
		<xsl:attribute name="name">user_id</xsl:attribute>
    </xsl:element>
    <xsl:element name="input">
        <xsl:attribute name="value"><xsl:value-of select="//user/@login" /></xsl:attribute>
        <xsl:attribute name="type">hidden</xsl:attribute>
		<xsl:attribute name="name">user_login</xsl:attribute>
    </xsl:element><br/>
    <img alt="Сохранить" style="cursor:pointer" onclick="this.parentNode.submit()" src="/i/bg{$pre_lang}/save.png" />
</form>
</xsl:template>
<!-- / смена пароля -->
<!-- сохранение в шаблоны -->
<xsl:template match="page[@type-id='10'][@id='9666'] | page[@type-id='10'][@id='13687'] | page[@type-id='10'][@id='12859']" >
	
    <xsl:element name="script">
        <xsl:attribute name="type">text/javascript</xsl:attribute>
        <xsl:comment>
    		if (is_friend() == '1') {
            	showTranslatedMsg('friend_login')
                if (document.getElementById('pre_lang_var')) var lang = document.getElementById('pre_lang_var').innerHTML 
                window.location.href = "http://www.lebongout.ru"+lang
            }
        </xsl:comment>
	</xsl:element>

<h1> <xsl:value-of select="$new_save_as_tpl"/>: </h1><br/>
<form method="post" action="{$pre_lang}/emarket/save_as_template/">
	<input type="hidden" name="order_id" value="{$order_id}" />
    <xsl:value-of select="$new_tpl_name"/>:<xsl:text> </xsl:text><input type="text" name="order_name" value="" class="textinputs" /><br/><br/><br/>
    <a href="{$pre_lang}/personal/all_orders_history/{$lite_q}"><img style="cursor:pointer" alt="Назад" src="/i/bg{$pre_lang}/stepback.png" /></a><xsl:text>  </xsl:text><img alt="Сохранить" style="cursor:pointer" onclick="this.parentNode.submit()" src="/i/bg{$pre_lang}/save.png" />
</form>
</xsl:template>
<!-- / сохранение в шаблоны -->
<!-- пополнение депозита -->
<xsl:template match="page[@type-id='10'][@id='10153'] | page[@type-id='10'][@id='13688'] | page[@type-id='10'][@id='12860']" >
	
    <xsl:element name="script">
        <xsl:attribute name="type">text/javascript</xsl:attribute>
        <xsl:comment>
    		if (is_friend() == '1') {
            	showTranslatedMsg('friend_login')
                if (document.getElementById('pre_lang_var')) var lang = document.getElementById('pre_lang_var').innerHTML 
                window.location.href = "http://www.lebongout.ru"+lang
            }
        </xsl:comment>
	</xsl:element>
    
<form method="post" action="{$pre_lang}/emarket/payDeposit/" id="pay_dep">
    
    <xsl:variable name="depId" select="document('udata://emarket/getCurrentDepositId/')//deposit/@depositId" />
    <h1 style="font-size:16px; font-weight:900;"><xsl:value-of select="$new_bablo_1" disable-output-escaping="yes" /></h1><br></br>
    <input type="hidden" name="depositId" value="{$depId}" />
    <input type="hidden" name="payExec" value="2" />
    <!--<label><input type="radio" value="2" name="depositValue" /> 2 <xsl:value-of select="$new_rub"/>.</label>-->
    <!--<xsl:param name="get_param" /> -->
   <!-- <xsl:if test="$get_param = 1">
    	<label><input type="radio" value="1000" name="depositValue"  /> 1000 <xsl:value-of select="$new_rub"/>.</label>
        <label><input type="radio" value="3000" name="depositValue" /> 3000 <xsl:value-of select="$new_rub"/>.</label>
        <label><input type="radio" value="5000" name="depositValue" /> 5000 <xsl:value-of select="$new_rub"/>.</label>
        <label><input type="radio" value="10000" name="depositValue" /> 10000 <xsl:value-of select="$new_rub"/>.</label>
        <label><input type="radio" value="20000" name="depositValue" /> 20000 <xsl:value-of select="$new_rub"/>.</label>
        <label><input type="radio" value="50000" name="depositValue" /> 50000 <xsl:value-of select="$new_rub"/>.</label>
        <br/>
        <br/>
        <h1 style="font-size:16px; font-weight:900;"><xsl:value-of select="$new_bablo_2" disable-output-escaping="yes" /></h1><br></br>
        <label><input type="radio" value="10000" name="depositValue" checked="checked"/> 10000 <xsl:value-of select="$new_rub"/>.</label>
    </xsl:if>
     <xsl:if test="$get_param = ''">
    	 <label><input type="radio" value="1000" name="depositValue" checked="checked" /> 1000 <xsl:value-of select="$new_rub"/>.</label>
        <label><input type="radio" value="3000" name="depositValue" /> 3000 <xsl:value-of select="$new_rub"/>.</label>
        <label><input type="radio" value="5000" name="depositValue" /> 5000 <xsl:value-of select="$new_rub"/>.</label>
        <label><input type="radio" value="10000" name="depositValue" /> 10000 <xsl:value-of select="$new_rub"/>.</label>
        <label><input type="radio" value="20000" name="depositValue" /> 20000 <xsl:value-of select="$new_rub"/>.</label>
        <label><input type="radio" value="50000" name="depositValue" /> 50000 <xsl:value-of select="$new_rub"/>.</label>
        <br/>
        <br/>
        <h1 style="font-size:16px; font-weight:900;"><xsl:value-of select="$new_bablo_2" disable-output-escaping="yes" /></h1><br></br>
        <label><input type="radio" value="10000" name="depositValue" /> 10000 <xsl:value-of select="$new_rub"/>.</label>
    </xsl:if>
    -->
  <!--  <label><input type="radio" value="1000" name="depositValue" checked="checked" /> 1000 <xsl:value-of select="$new_rub"/>.</label>
	<label><input type="radio" value="3000" name="depositValue" /> 3000 <xsl:value-of select="$new_rub"/>.</label>
    <label><input type="radio" value="5000" name="depositValue" /> 5000 <xsl:value-of select="$new_rub"/>.</label>
    <label><input type="radio" value="10000" name="depositValue" /> 10000 <xsl:value-of select="$new_rub"/>.</label>
    <label><input type="radio" value="20000" name="depositValue" /> 20000 <xsl:value-of select="$new_rub"/>.</label>
    <label><input type="radio" value="50000" name="depositValue" /> 50000 <xsl:value-of select="$new_rub"/>.</label>
    <br/>
    <br/>
    <h1 style="font-size:16px; font-weight:900;"><xsl:value-of select="$new_bablo_2" disable-output-escaping="yes" /></h1><br></br>
    <label><input type="radio" value="10000" name="depositValue" /> 10000 <xsl:value-of select="$new_rub"/>.</label>
    
    -->
    
    	 <xsl:choose>
            <xsl:when test="$get_param = 1">
                <label><input type="radio" value="1000" name="depositValue"  /> 1000 <xsl:value-of select="$new_rub"/>.</label>
        <label><input type="radio" value="3000" name="depositValue" /> 3000 <xsl:value-of select="$new_rub"/>.</label>
        <label><input type="radio" value="5000" name="depositValue" /> 5000 <xsl:value-of select="$new_rub"/>.</label>
        <label><input type="radio" value="10000" name="depositValue" /> 10000 <xsl:value-of select="$new_rub"/>.</label>
        <label><input type="radio" value="20000" name="depositValue" /> 20000 <xsl:value-of select="$new_rub"/>.</label>
        <label><input type="radio" value="50000" name="depositValue" /> 50000 <xsl:value-of select="$new_rub"/>.</label>
        <br/>
        <br/>
       <!-- <h1 style="font-size:16px; font-weight:900;"><xsl:value-of select="$new_bablo_2" disable-output-escaping="yes" /></h1><br></br>
        <label><input type="radio" value="10000" name="depositValue" checked="checked"/> 10000 <xsl:value-of select="$new_rub"/>.</label>-->
            </xsl:when>   
            <xsl:otherwise>
                <label><input type="radio" value="1000" name="depositValue" checked="checked" /> 1000 <xsl:value-of select="$new_rub"/>.</label>
        <label><input type="radio" value="3000" name="depositValue" /> 3000 <xsl:value-of select="$new_rub"/>.</label>
        <label><input type="radio" value="5000" name="depositValue" /> 5000 <xsl:value-of select="$new_rub"/>.</label>
        <label><input type="radio" value="10000" name="depositValue" /> 10000 <xsl:value-of select="$new_rub"/>.</label>
        <label><input type="radio" value="20000" name="depositValue" /> 20000 <xsl:value-of select="$new_rub"/>.</label>
        <label><input type="radio" value="50000" name="depositValue" /> 50000 <xsl:value-of select="$new_rub"/>.</label>
        <br/>
        <br/>
       <!-- <h1 style="font-size:16px; font-weight:900;"><xsl:value-of select="$new_bablo_2" disable-output-escaping="yes" /></h1><br></br>
        <label><input type="radio" value="123" name="depositValue" /> 10000 <xsl:value-of select="$new_rub"/>.</label> -->
            </xsl:otherwise>
        </xsl:choose>
    
    
    <br/>
    <br/>
    <br/>
    <img alt="Оплатить" style="cursor:pointer" onclick="this.parentNode.submit()" src="/i/bg{$pre_lang}/pay.png" />
    <!-- setDepositValue('{$depId}')
    <xsl:text>pay deposit</xsl:text>
		<xsl:apply-templates select="document(concat('udata://emarket/payDeposit/?depositId=',$depId))//purchasing" />-->
    
</form>
</xsl:template>
<!-- /пополнение депозита -->
<!-- /пополнение депозита -->
<!-- Оправить приглашение другу -->
<xsl:template match="page[@type-id='10'][@id='10335'] | page[@type-id='10'][@id='13690'] | page[@type-id='10'][@id='12862']" >
 <form id="friend-signup" action="http://lebongout.ru/profile/profile/friend.php?action=1" method="post" name="friend">
 		<xsl:variable name="nums" select="document(concat('uobject://', /result/user/@id))//property[@name='clientcode']/value" />
    	<table>
        	<tr>
            	<td style="width:200px"><xsl:value-of select="$new_lastname"/></td>
                <td style="width:400px"><input name="lname"  type="text" size="40" maxlength="100" /></td>
            </tr>
                <tr style="height:5px;">
                    <td colspan="2"></td>
                </tr>
            <tr>
            	<td style="width:200px"><xsl:value-of select="$new_firstname"/></td>
                <td style="width:400px"><input name="fname"  type="text" size="40" maxlength="100" /></td>
            </tr>
            	<tr style="height:5px;">
                    <td colspan="2"></td>
                </tr>
            <tr>
            	<td style="width:200px"><xsl:value-of select="$new_fathername"/></td>
                <td style="width:400px"><input name="patr" type="text" size="40" maxlength="100"/></td>
            </tr>
            	<tr style="height:5px;">
                    <td colspan="2"></td>
                </tr>
            <tr>
            	<td style="width:200px">E-mail</td>
                <td style="width:400px"><input name="email" type="text" size="40" maxlength="100"/></td>
            </tr>
            	<tr style="height:5px;">
                    <td colspan="2"></td>
                </tr>
            <tr>
            	<td style="width:200px"><xsl:value-of select="$new_sex"/></td>
                <td style="width:400px"><select name="sex">
                      <option value="male"><xsl:value-of select="$new_male"/></option>
                      <option value="female"><xsl:value-of select="$new_female"/></option>
                    </select>
                </td>
            </tr>
            	<tr style="height:5px;">
                    <td colspan="2"></td>
                </tr>
             <tr>
            	<td style="width:200px"><input type="hidden" name="clientcode" value="{$nums}" /></td>
                <td style="width:400px"><input type="submit" id="signup-button" value="{$new_send}" /></td>
            </tr>
       </table>    
       </form>
       <p id="signup-response"></p>
</xsl:template>
<!-- /Оправить приглашение другу -->
<!-- Вся финансовая история -->
<xsl:template match="page[@type-id='10'][@id='11105'] | page[@type-id='10'][@id='12863'] | page[@type-id='10'][@id='13691']" >
	
    <xsl:element name="script">
        <xsl:attribute name="type">text/javascript</xsl:attribute>
        <xsl:comment>
    		if (is_friend() == '1') {
            	showTranslatedMsg('friend_login')
                if (document.getElementById('pre_lang_var')) var lang = document.getElementById('pre_lang_var').innerHTML 
                window.location.href = "http://www.lebongout.ru"+lang
            }
        </xsl:comment>
	</xsl:element>
    
    <table id="fin_history">
        <xsl:apply-templates select="document('udata://emarket/get_financial_story/')//item" mode="fin-history-preiew" />
    </table><br/><br/>
</xsl:template>
<!-- / Вся финансовая история -->
<!-- Промо страница -->
<xsl:template match="page[@type-id='1102']" >
	<xsl:variable name="currPageId" select="@id" />
	<div class="product">
                <div class="zag" style="color: #b7cb79;"><xsl:value-of select="//property[@name='title']/value" disable-output-escaping="yes" /></div><br/>
                	<div style="float:right;">
                        <div class="product-preview" style="margin-top:0px;margin-left: 20px;margin-top: 4px;">
                            <img src="{//property[@name='picture']/value}" width="240px" height="240px"/>
                        </div>
                        <div class="descriptions_idea">
                        <p align="justify"><xsl:value-of select="//property[@name='description']/value" disable-output-escaping="yes" /></p>    
                        </div>
                		<br/>
                        <div class="descriptions_idea" style="padding-top:20px; ">
                             <p align="justify">
                                 <xsl:value-of select="//property[@name='recipe_text']/value" disable-output-escaping="yes" /> 
                            </p>
                        </div>
                   </div>
               <table border="0" style="width:100%;"><tr><td>
                </td></tr></table>    
                <table border="0" width="100%"><tr><td>
                       <!-- <xsl:for-each select="//property[@name='recipe']/value/item">
                        	<xsl:sort select="document(concat('uobject://', @id))//property[@name='type']/value/item/@name" order="ascending" data-type="text" lang="ru"/>
                        	<xsl:apply-templates select="document(concat('uobject://', @id))" mode="rec-products"/>
                        </xsl:for-each>-->

                        <xsl:for-each select="//property[@name='recipe']/value/item" >
            				<!--<xsl:sort select="document(concat('uobject://', @id))//property[@name='type']/value/item/@name" order="ascending" data-type="text" lang="ru"/>-->
                            <xsl:sort select="document(concat('uobject://', document(concat('uobject://', @id))//property[@name='type']/value/item/@id))//property[@name='order_num']/value" order="ascending" data-type="number"/>
                           <xsl:variable name="obz" select="document(concat('uobject://', document(concat('uobject://', @id))//property[@name='type']/value/item/@id))//property[@name='obyazatelnye_produkty']/value"/>
                           <!-- Выводим заголовок для первого элемента -->
                           <xsl:if test="position() = 1">
                           	  <xsl:if test="$obz = 1">
                                <div class="zag" style="color: #b7cb79;">         
                                	<xsl:choose>
                                        <xsl:when test="$pre_lang = '/fr'">
                                            <xsl:value-of select="document(concat('uobject://', document(concat('uobject://', @id))//property[@name='type']/value/item/@id))//property[@name='name_fr']/value" />
                                        </xsl:when>
                                        <xsl:when test="$pre_lang = '/en'">
                                            <xsl:value-of select="document(concat('uobject://', document(concat('uobject://', @id))//property[@name='type']/value/item/@id))//property[@name='name_en']/value" />
                                        </xsl:when>
                                        <xsl:otherwise>
                                           <xsl:value-of select="document(concat('uobject://', @id))//property[@name='type']/value/item/@name" />
                                        </xsl:otherwise>
                                    </xsl:choose>  
                                </div>
                               </xsl:if>      
                           </xsl:if>
                   
                            <!-- Сохраняем в переменные текущие значения для цикла --> 
                            <xsl:variable name="tmp2" select="position()-1" />
                            <!-- select="document(concat('uobject://', @id))//property[@name='type']/value/item/@name"  -->
                            <xsl:variable name="tmp3">
                            	<xsl:choose>
                                    <xsl:when test="$pre_lang = '/fr'">
                                        <xsl:value-of select="document(concat('uobject://', document(concat('uobject://', @id))//property[@name='type']/value/item/@id))//property[@name='name_fr']/value" />
                                    </xsl:when>
                                    <xsl:when test="$pre_lang = '/en'">
                                        <xsl:value-of select="document(concat('uobject://', document(concat('uobject://', @id))//property[@name='type']/value/item/@id))//property[@name='name_en']/value" />
                                    </xsl:when>
                                    <xsl:otherwise>
                                       <xsl:value-of select="document(concat('uobject://', @id))//property[@name='type']/value/item/@name" />
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:variable>
                            
                    <!-- В новом цикле с такой же сортировкой ищем элемент с индексом -1 от текущего в родительском цикле -->
                    <xsl:for-each select="document(concat('upage://', $currPageId))//property[@name='recipe']/value/item">
                    	<!--<xsl:sort select="document(concat('uobject://', @id))//property[@name='type']/value/item/@name" order="ascending" data-type="text" lang="ru"/>-->
                        <xsl:sort select="document(concat('uobject://', document(concat('uobject://', @id))//property[@name='type']/value/item/@id))//property[@name='order_num']/value" order="ascending" data-type="number"/>
                    <!-- Если предыдущий элемент имел другую дату доставки, то выводим новый заголовок-дату-->
                    		<xsl:variable name="tmp4">
                            	<xsl:choose>
                                    <xsl:when test="$pre_lang = '/fr'">
                                        <xsl:value-of select="document(concat('uobject://', document(concat('uobject://', @id))//property[@name='type']/value/item/@id))//property[@name='name_fr']/value" />
                                    </xsl:when>
                                    <xsl:when test="$pre_lang = '/en'">
                                        <xsl:value-of select="document(concat('uobject://', document(concat('uobject://', @id))//property[@name='type']/value/item/@id))//property[@name='name_en']/value" />
                                    </xsl:when>
                                    <xsl:otherwise>
                                       <xsl:value-of select="document(concat('uobject://', @id))//property[@name='type']/value/item/@name" />
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:variable>
                        <!--<xsl:if test="(position() = $tmp2) and (document(concat('uobject://', @id))//property[@name='type']/value/item/@name != $tmp3)">-->
                        	<xsl:if test="(position() = $tmp2) and ($tmp4 != $tmp3)">
                        	<br/><br/>
                        	<div class="zag" style="color: #b7cb79;">  
                            	<xsl:value-of select="$tmp3" />
                            </div>
                            
                        </xsl:if>
                    </xsl:for-each>
                    <xsl:if test="$obz = 1">
					<table border="0" cellpadding="0" cellspacing="0" style="display:inline-block; overflow:hidden; vertical-align:top;">
                    <tr height="*">
                     <td width="90px" style="text-align:center;">
                     <a href="{$pre_lang}/catalog_search/?c_id={document(concat('upage://', document(concat('uobject://', @id))//property[@name='product']/value))//page/@id}{$lite_a}">
                    	<img width="80px" height="80px" src="{document(concat('upage://', document(concat('uobject://', @id))//property[@name='product']/value))//property[@name='photo']/value}" />
                     </a>
                     <br/>
                     <xsl:variable name="cols" select="document(concat('uobject://', @id))//property[@name='amount']/value" />
                     <xsl:choose>
                            <xsl:when test="$cols > 1">
                                <xsl:value-of select="$cols" disable-output-escaping="yes" /><span style="padding-left:5px;"></span>
                                 <xsl:choose>
                                    <xsl:when test="$pre_lang = '/fr'">
                                       gr
                                    </xsl:when>
                                    <xsl:when test="$pre_lang = '/en'">
                                       g
                                    </xsl:when>
                                    <xsl:otherwise>
                                       гр
                                    </xsl:otherwise>
                                 </xsl:choose>
                            </xsl:when>
                            <xsl:when test="$cols = 1">
                                <xsl:value-of select="$cols" disable-output-escaping="yes" /><span style="padding-left:5px;"></span><xsl:value-of select="$new_thing" disable-output-escaping="yes" />
                            </xsl:when>
                            <xsl:otherwise>
                               <xsl:value-of select="$cols * 10" disable-output-escaping="yes" /><span style="padding-left:5px;"></span><xsl:value-of select="$new_thing" disable-output-escaping="yes" />
                            </xsl:otherwise>
                         </xsl:choose>
                     </td>
                    </tr>
                    <tr style="overflow:hidden;vertical-align:top;">
                     <td width="90px" style="text-align:center;overflow:hidden;vertical-align:top;height:30px;">
                		<!--<xsl:value-of select="document(concat('upage://', document(concat('uobject://', @id))//property[@name='product']/value))//property[@name='shortname']/value" />-->
                        <xsl:choose>
                            <xsl:when test="$pre_lang = '/fr'">
                                <xsl:value-of select="document(concat('upage://', document(concat('uobject://', @id))//property[@name='product']/value))//property[@name='shortname_fr']/value" disable-output-escaping="yes" />
                            </xsl:when>
                            <xsl:when test="$pre_lang = '/en'">
                                <xsl:value-of select="document(concat('upage://', document(concat('uobject://', @id))//property[@name='product']/value))//property[@name='shortname_en']/value" disable-output-escaping="yes" />
                            </xsl:when>
                            <xsl:otherwise>
                               <xsl:value-of select="document(concat('upage://', document(concat('uobject://', @id))//property[@name='product']/value))//property[@name='shortname']/value" disable-output-escaping="yes" />
                            </xsl:otherwise>
                         </xsl:choose>
                     </td>
                    </tr>
                 </table>
                	</xsl:if>
            </xsl:for-each>
                       
					</td></tr></table>
                    <br/><br/><div style="color:#000000;"><xsl:value-of select="//property[@name='comment']/value" disable-output-escaping="yes" /></div>
                    <xsl:if test="document(concat('udata://emarket/isNeedPutPromotoCart/?pageObj=', @object-id))//to_cart = '1'">
                    <div class="product-order">
                                <ul class="set-mass">
                         <li class="add"  title="Уменьшить количество"><a href="javascript:promo_amount(false,'{@object-id}');">-</a></li>
                         <li class="mass" style="width:170px;"><xsl:value-of select="$new_kit" /><xsl:text> </xsl:text><span id="amount_promo_view" style="font-size:18px;">1</span></li>
                        <li class="deduct" title="Увеличить количество"><a href="javascript:promo_amount(true,'{@object-id}');">+</a></li>
            </ul>
                                
                                <em class="price">
                                
                                <span id="price_promo"><xsl:value-of select="document(concat('udata://emarket/getPromoPrice/?pageObj=', @object-id))" /></span> <xsl:value-of select="$new_rub" />.
                                
                                </em>
                                <a href="javascript:add_promo_to_cart({@object-id});" class="add-to-cart">Add to cart</a>
                            </div>
                      </xsl:if>
                            <br/>
                
                     <!-- Вывод ингридиентов рецепта -->
                <table border="0" width="100%">
                	<tr><td>
                       <xsl:for-each select="//property[@name='recipe']/value/item" >
                       <xsl:sort select="document(concat('uobject://', document(concat('uobject://', @id))//property[@name='type']/value/item/@id))//property[@name='order_num']/value" order="ascending" data-type="number"/>
                       		<xsl:variable name="dop" select="document(concat('uobject://', document(concat('uobject://', @id))//property[@name='type']/value/item/@id))//property[@name='dopolnitelnye_produkty']/value"/>
                            <xsl:variable name="obz" select="document(concat('uobject://', document(concat('uobject://', @id))//property[@name='type']/value/item/@id))//property[@name='obyazatelnye_produkty']/value"/>
                       		<xsl:if test="$dop = 1">
                                  <xsl:if test="position() = 1">
                                        <div class="zag" style="color: #b7cb79;">         
                                            <xsl:choose>
                                                <xsl:when test="$pre_lang = '/fr'">
                                                    <xsl:value-of select="document(concat('uobject://', document(concat('uobject://', @id))//property[@name='type']/value/item/@id))//property[@name='name_fr']/value" />
                                                </xsl:when>
                                                <xsl:when test="$pre_lang = '/en'">
                                                    <xsl:value-of select="document(concat('uobject://', document(concat('uobject://', @id))//property[@name='type']/value/item/@id))//property[@name='name_en']/value" />
                                                </xsl:when>
                                                <xsl:otherwise>
                                                   <xsl:value-of select="document(concat('uobject://', @id))//property[@name='type']/value/item/@name" />
                                                </xsl:otherwise>
                                            </xsl:choose>  
                                        </div>      
                                   </xsl:if>
                                   <!-- / Блок товаров --> 
                 <table border="0" cellpadding="0" cellspacing="0" style="display:inline-block; overflow:hidden; vertical-align:top;">
                    <tr height="*">
                     <td width="140px" style="text-align:center;">
                     <a href="{$pre_lang}/catalog_search/?c_id={document(concat('upage://', document(concat('uobject://', @id))//property[@name='product']/value))//page/@id}{$lite_a}">
                    	<img width="80px" height="80px" src="{document(concat('upage://', document(concat('uobject://', @id))//property[@name='product']/value))//property[@name='photo']/value}" />
                     </a>
                     <br/>
                     		
               					<!--Получение переменных -->
       <!--<xsl:value-of select="document(concat('upage://', document(concat('uobject://', @id))//property[@name='product']/value))//property[@name='shortname_fr']/value" disable-output-escaping="yes" />-->
       <xsl:variable name="stv" select="document(concat('upage://', document(concat('uobject://', @id))//property[@name='product']/value))//property[@name='stv']/value" disable-output-escaping="yes"/>
       <xsl:variable name="ves_one" select="document(concat('upage://', document(concat('uobject://', @id))//property[@name='product']/value))//property[@name='weight_stuka']/value * 1000" disable-output-escaping="yes" />
       <xsl:variable name="ves_min" select="document(concat('upage://', document(concat('uobject://', @id))//property[@name='product']/value))//property[@name='min_weight']/value * 1000" disable-output-escaping="yes" />
       <xsl:variable name="unit" select="document(concat('upage://', document(concat('uobject://', @id))//property[@name='product']/value))//property[@name='unit']/value" disable-output-escaping="yes" />
       <xsl:variable name="pcena" select="document(concat('upage://', document(concat('uobject://', @id))//property[@name='product']/value))//property[@name='price']/value" disable-output-escaping="yes" />
       <xsl:variable name="idproduct" select="document(concat('uobject://', @id))//property[@name='product']/value" />
                                <!--/Получение переменных -->
                                	<!--Блок работы с ценой -->
         <xsl:choose>
         	<xsl:when test="($unit = 'шт') or ($unit = 'упак')">
            	<ul class="set-mass">
                    <li class="add"  title="Уменьшить кол-во"><a href="javascript:sfa_amount({$idproduct}, false, '{$unit}', '{$unit}', '{$new_gr}', false);">-</a></li>
                    <li class="mass" id="amount_user_{$idproduct}">1<xsl:text> </xsl:text><xsl:value-of select="$unit" /></li>
                    <li class="deduct" title="Увеличить кол-во"><a href="javascript:sfa_amount({$idproduct}, true, '{$unit}', '{$unit}', '{$new_gr}', false);">+</a></li>
                    <br/>
                    <input type="hidden" name="amount" value="1" id="amount_{$idproduct}" />
                    <br/>
                    <xsl:value-of select="$pcena" /><xsl:text> </xsl:text><xsl:value-of select="$new_rub" disable-output-escaping="yes" />/<xsl:value-of select="$unit" />
                    <br/>
                    <a href="javascript:sfa_cart_add('{$idproduct}', 'amount_{$idproduct}', true);" id="c_{$idproduct}" class="add-to-cart" title="В корзину">Add to cart</a>
                </ul>
            </xsl:when>
            <xsl:when test="$unit = 'кг'">
            	<xsl:choose>
                     <xsl:when test="$stv = 1">
                       		<ul class="set-mass">
                                <li class="add" title="Уменьшить кол-во"><a href="javascript:sfa_amount2({$idproduct}, false, {$ves_one}, '', '{$new_thing}', '{$new_gr}');">-</a></li>
                                <li class="mass" id="amount_user_{$idproduct}"><xsl:value-of select="$ves_one" /><xsl:text> </xsl:text><xsl:value-of select="$new_gr" disable-output-escaping="yes" /><br></br>1<xsl:text> </xsl:text><xsl:value-of select="$new_thing" disable-output-escaping="yes" /></li>
                                <li class="deduct" title="Увеличить кол-во"><a href="javascript:sfa_amount2({$idproduct}, true, {$ves_one}, '', '{$new_thing}', '{$new_gr}');">+</a></li>
                                <br/>
                                <input type="hidden" name="amount" value="{$ves_one}" id="amount_{$idproduct}" />
                                <br/>
                                <xsl:value-of select="$pcena * 1000" /><xsl:text> </xsl:text><xsl:value-of select="$new_rub" disable-output-escaping="yes" />/<xsl:value-of select="$unit" />
                                <br/>
                                <a href="javascript:sfa_cart_add('{$idproduct}', 'amount_{$idproduct}', true);" id="c_{$idproduct}" class="add-to-cart" title="В корзину">Add to cart</a>
               				 </ul>
                     </xsl:when>
                     <xsl:otherwise>
                              <ul class="set-mass">
                                <li class="add"  title="Уменьшить кол-во"><a href="javascript:sfa_amount({$idproduct}, false, '{$unit}', '{$unit}', '{$new_gr}', '{$ves_min}');">-</a></li>
                                <li class="mass" id="amount_user_{$idproduct}"><xsl:value-of select="$ves_min" /><xsl:text> </xsl:text><xsl:value-of select="$new_gr" disable-output-escaping="yes" /></li>
                                <li class="deduct" title="Увеличить кол-во"><a href="javascript:sfa_amount({$idproduct}, true, '{$unit}', '{$unit}', '{$new_gr}', '{$ves_min}');">+</a></li>
                                <br/>
                                <input type="hidden" name="amount" value="1" id="amount_{$idproduct}" />
                                <br/>
                                <xsl:value-of select="$pcena * 1000" /><xsl:text> </xsl:text><xsl:value-of select="$new_rub" disable-output-escaping="yes" />/<xsl:value-of select="$unit" />
                                <br/>
                                <a href="javascript:sfa_cart_add('{$idproduct}', 'amount_{$idproduct}', true);" id="c_{$idproduct}" class="add-to-cart" title="В корзину">Add to cart</a>
               				 </ul>
                     </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
         </xsl:choose> 
                     </td>
                    </tr>
                    <tr style="overflow:hidden;vertical-align:top;">
                     <td width="90px" style="text-align:center;overflow:hidden;vertical-align:top;height:30px;">
                		<!--<xsl:value-of select="document(concat('upage://', document(concat('uobject://', @id))//property[@name='product']/value))//property[@name='shortname']/value" />-->
                        <xsl:choose>
                            <xsl:when test="$pre_lang = '/fr'">
                                <xsl:value-of select="document(concat('upage://', document(concat('uobject://', @id))//property[@name='product']/value))//property[@name='shortname_fr']/value" disable-output-escaping="yes" />
                            </xsl:when>
                            <xsl:when test="$pre_lang = '/en'">
                                <xsl:value-of select="document(concat('upage://', document(concat('uobject://', @id))//property[@name='product']/value))//property[@name='shortname_en']/value" disable-output-escaping="yes" />
                            </xsl:when>
                            <xsl:otherwise>
                               <xsl:value-of select="document(concat('upage://', document(concat('uobject://', @id))//property[@name='product']/value))//property[@name='shortname']/value" disable-output-escaping="yes" />
                            </xsl:otherwise>
                         </xsl:choose>
                     </td>
                    </tr>
                 </table>
                 <!--<p><xsl:text> </xsl:text></p>-->
                    <!-- / Блок товаров -->      
                            </xsl:if>
                        </xsl:for-each>                    	
                    </td></tr>
                    <tr><td><p><xsl:text> </xsl:text></p></td></tr>
                </table>
                <!-- / Вывод необязательных товарных позиций -->
				</div>
</xsl:template>
<!-- / Промо страница -->

<!-- Шлюз загрузки страниц каталога -->
<xsl:param name="c_id" />
<xsl:template match="page[@type-id='10'][@id='16120'] | page[@type-id='10'][@id='16121'] | page[@type-id='10'][@id='16122']" >
    	<xsl:choose>
        	<xsl:when test="$c_id = ''">
            	<xsl:apply-templates select="document('upage://2300')//page"/>
            </xsl:when>
            <xsl:otherwise>
            	<xsl:apply-templates select="document(concat('upage://', $c_id))//page"/>
            </xsl:otherwise>
    	</xsl:choose>
</xsl:template>
<!-- Пришлось делать два идентичных блоке, так как необходимо было выставить каталожную страницу в качестве главной. Но, если выставить страницу шлюза напряую, это приводило к потере кликабельности ссылок. Параметр c_id переставал приниматься. -->
<xsl:template match="page[@type-id='10'][@id='12255'] | page[@type-id='10'][@id='13082'] | page[@type-id='10'][@id='1']" >
		<!-- Вывод контента на главной странице (каталожной в виде главной) -->
        <xsl:value-of select=".//property[@name = 'content']/value" disable-output-escaping="yes" />                   
        <!--/ Вывод контента на главной странице (каталожной в виде главной) -->
    	<xsl:choose>
        	<xsl:when test="$c_id = ''">
            	<xsl:choose>
            		<xsl:when test="document('udata://emarket/is_friend_login/')//is_friend = '1'">
                    	<xsl:element name="script">
                            <xsl:attribute name="type">text/javascript</xsl:attribute>
                            <xsl:comment>
                                window.location.href = "<xsl:value-of select="$pre_lang" />/o_proekte"
                            </xsl:comment>
                        </xsl:element>
                    	<!--<xsl:apply-templates select="document('upage://11')//page"/>-->
                    </xsl:when>
                  <!--  <xsl:when test="document(concat('uobject://',/result/user/@id))//property[@name='status']/value = 1 ">
                          <xsl:element name="script">
                            <xsl:attribute name="type">text/javascript</xsl:attribute>
                            <xsl:comment>
                                window.location.href = "<xsl:value-of select="$pre_lang" />/welcome_page"
                            </xsl:comment>
                        </xsl:element>
                    </xsl:when>-->
                    <xsl:otherwise>
                    	<xsl:apply-templates select="document('upage://2300')//page"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
            	<xsl:apply-templates select="document(concat('upage://', $c_id))//page"/>
            </xsl:otherwise>
    	</xsl:choose>  
</xsl:template>
<!-- / Шлюз загрузки страниц каталога -->

<!-- Страница со спецпредложениями -->
<xsl:param name="page_id" />
<xsl:template match="page[@id='19514'] | page[@id='19851'] | page[@id='19849']" >
<ul class="specials">
   <xsl:apply-templates select="document(concat('udata://custom/page_childs/?page=', @id))//page" mode="special-list" />
</ul>
</xsl:template>

<xsl:template match="page" mode="special-list">
	<xsl:apply-templates select="document(concat('upage://', id))//page" mode="special-list-page" />
</xsl:template>

<xsl:template match="page" mode="special-list-page">
  <li class="p_spc"> 
  		<a class="head_img" href="{concat($pre_lang, '/special_selections/',@alt-name,'/',$lite_q)}"><img src="{//property[@name = 'header_pic2']/value}" style="text-decoration:none;"/></a> 
		<a class="head_text" href="{concat($pre_lang, '/special_selections/',@alt-name,'/',$lite_q)}"><xsl:value-of select="name" disable-output-escaping="yes" /></a>
      <div><xsl:value-of select="//property[@name = 'banner_text']/value"  disable-output-escaping="yes"  /></div>
  </li>
</xsl:template>

<xsl:template match="page[@type-id = '1117']">
	<xsl:variable name="start_price" select="//property[@name = 'start_price']/value" />
    <xsl:variable name="end_price" select="//property[@name = 'end_price']/value" />
    <xsl:variable name="bio" select="//property[@name = 'bio']/value" />
    <xsl:variable name="organic" select="//property[@name = 'organic']/value" />
    <xsl:variable name="on_stock" select="//property[@name = 'on_stock']/value" />
    <xsl:variable name="for_order" select="//property[@name = 'for_order']/value" />
    <xsl:variable name="title_like" select="php:function('urlencode', string(//property[@name = 'title_like']/value))" />
    <xsl:variable name="country">
    	<xsl:if test="//property[@name = 'country']/combined != ''">
    		<xsl:value-of select="concat(',',php:function('urlencode', string(//property[@name = 'country']/combined)),',')" />
    	</xsl:if>
    </xsl:variable>
    <xsl:variable name="manufacturer" >
        <xsl:if test="//property[@name = 'manufacturer']/combined != ''">
            <xsl:value-of select="concat(',',php:function('urlencode', string(//property[@name = 'manufacturer']/combined)),',')" />
        </xsl:if>
	</xsl:variable>  
    <xsl:variable name="catalog_cat">
    	<xsl:if test="//property[@name = 'catalog_cat']/combined != ''">
            <xsl:value-of select="concat(',',//property[@name = 'catalog_cat']/combined,',')" />
        </xsl:if>
    </xsl:variable>
    <xsl:variable name="product_cat">
    	<xsl:if test="//property[@name = 'product_cat']/combined != ''">
    		<xsl:value-of select="concat(',',php:function('urlencode', string(//property[@name = 'product_cat']/combined)),',')" />
        </xsl:if>
     </xsl:variable>
    <xsl:variable name="start_date" select="//property[@name = 'start_date']//value/@unix-timestamp" />
    <xsl:variable name="end_date" select="//property[@name = 'end_date']//value/@unix-timestamp" />
   
   <xsl:element name="script">
        <xsl:attribute name="type">text/javascript</xsl:attribute>
        <xsl:comment>
    		iArr = new Array()
        </xsl:comment>
	</xsl:element>
    
    <ul class="products{$lite_suff}">
        <xsl:choose>
        	<xsl:when test="$pre_lang = '/fr'">
            	<xsl:apply-templates select="document(concat('udata://custom/catalog_products_by_param/?start_price=', $start_price, '&amp;end_price=', $end_price, '&amp;bio=', $bio, '&amp;organic=', $organic, '&amp;on_stock=', $on_stock, '&amp;for_order=', $for_order, '&amp;title_like=', $title_like, '&amp;country=', $country, '&amp;manufacturer=', $manufacturer, '&amp;catalog_cat=', $catalog_cat, '&amp;product_cat=', $product_cat, '&amp;start_date=', $start_date, '&amp;end_date=', $end_date))//page" mode="product_block_props">
            		<xsl:sort select="properties/property[@name='shortname_fr']/value" order="ascending" data-type="text" lang="fr"/>
                 </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="$pre_lang = '/en'">
            	<xsl:apply-templates select="document(concat('udata://custom/catalog_products_by_param/?start_price=', $start_price, '&amp;end_price=', $end_price, '&amp;bio=', $bio, '&amp;organic=', $organic, '&amp;on_stock=', $on_stock, '&amp;for_order=', $for_order, '&amp;title_like=', $title_like, '&amp;country=', $country, '&amp;manufacturer=', $manufacturer, '&amp;catalog_cat=', $catalog_cat, '&amp;product_cat=', $product_cat, '&amp;start_date=', $start_date, '&amp;end_date=', $end_date))//page" mode="product_block_props">
            		<xsl:sort select="properties/property[@name='shortname_en']/value" order="ascending" data-type="text" lang="en"/>
                 </xsl:apply-templates>
            </xsl:when>
            <xsl:otherwise>
            	<xsl:apply-templates select="document(concat('udata://custom/catalog_products_by_param/?start_price=', $start_price, '&amp;end_price=', $end_price, '&amp;bio=', $bio, '&amp;organic=', $organic, '&amp;on_stock=', $on_stock, '&amp;for_order=', $for_order, '&amp;title_like=', $title_like, '&amp;country=', $country, '&amp;manufacturer=', $manufacturer, '&amp;catalog_cat=', $catalog_cat, '&amp;product_cat=', $product_cat, '&amp;start_date=', $start_date, '&amp;end_date=', $end_date))//page" mode="product_block_props">
            		<xsl:sort select="properties/property[@name='shortname']/value" order="ascending" data-type="text" lang="ru"/>
                 </xsl:apply-templates>
            </xsl:otherwise>
        </xsl:choose>        
    </ul>
    
    <xsl:element name="script">
        <xsl:attribute name="type">text/javascript</xsl:attribute>
        <xsl:comment>      
        	$('.add-to-cart').bind('mousedown', function(){var of = $(this).offset();mx  = of.left;my  = of.top;})

            if (document.getElementById("filter_form")) {
                var lis=document.getElementsByTagName("li")
                for( var i=0; i &lt; lis.length; i++)
                     if (lis[i].className=="p_c") {
                        if ($(lis[i]).find("span").filter(".bio").html() != "") {
                            document.getElementById("filter_by_bio").parentNode.style.display = "block"
                            break
                        }
                     }
                
                
                if (document.getElementById("filter_form")) {
                var lis=document.getElementsByTagName("li")
   				            
            }
                
                if (document.getElementById("filter_by_country")) {
                    var lis=document.getElementsByTagName("li")
                    var cn3s=document.getElementById("filter_by_country").getElementsByTagName("option")

                    for( var j=1; j &lt; cn3s.length; j++) {
                        var currCn3 = cn3s[j].innerHTML
                        for( var i=0; i &lt; lis.length; i++)
                             if (lis[i].className=="p_c") {
                                if ($(lis[i]).find("span").filter(".cn3").html() == currCn3) {
                                    cn3s[j].style.display = "block"
                                    break
                                }
                             }
                    } 
                }   
                
                document.getElementById("filter_form").style.display = "block"
            }
    		        
            
            for(var i=0;i &lt; iArr.length;i++){
                document.getElementById(iArr[i][0]).src = iArr[i][1]
            }
        </xsl:comment>
	</xsl:element>

</xsl:template>
<!--
<xsl:template match="page" mode="special-items">
	<div style="padding-right: 10px; float:left; text-align:center; height:100px;vertical-align:bottom;">
      <a href="{concat($pre_lang, '/catalog_search/?c_id=',@id)}"><img height="80px" src="{header_pic}" style="text-decoration:none;"/><br/>
          <xsl:value-of select="name"  disable-output-escaping="yes"  />
      </a>
     </div>
</xsl:template>-->

<!-- / Страница со спецпредложениями -->


<!-- Стартовая страница менеджера -->
<xsl:template match="page[@id='54268']" >

	<xsl:variable name="is_manager" select="document('udata://emarket/is_manager_login/')//is_manager" />

	<xsl:choose>
		<xsl:when test="$is_manager = '1'">
			<h1>Стартовая страница продавца</h1>
			<br/>
			1. <a href="/manager_start_page/manager_add_order/">Добавить заказ</a> / <a href="/manager_start_page/manager_order_commit/">Продолжить оформление последнего заказа</a><br/>
			2. <a href="/manager_start_page/manager_orders_list_page/">Оформленные заказы</a><br/>
			3. <a href="/manager_start_page/make_deposit/">Пополнение депозита.</a> <br/>
			4. <a href="/manager_start_page/getting_cash/">Получение денежны средств [Отчет].</a> <br/>
			5. <a href="/manager_start_page/getting_cash_orders/">Список заказов и оплат [Отчет].</a> 
			<br/><br/>
			<script type="text/javascript" src="/js/loginform.js"></script>
			<h3>Регистрация нового клиента:</h3>	
				<form id="mesageform" action="/profile/cybershop/AddNewUser.php" method="POST">
                    <div class="zag_a"><xsl:value-of select="$new_lastname" disable-output-escaping="yes" /><span class="zag_a" id="alert_1" style="display:none; color:#930;"><xsl:value-of select="$new_auth_alertlastname" disable-output-escaping="yes" /></span></div>
                    
                    <input type="text" id="lname" name="lname"/>
                    <br/>
                    <div class="zag_a"><xsl:value-of select="$new_firstname" disable-output-escaping="yes" />  <div class="zag_a" id="alert_2" style="display:none; color:#930;"><xsl:value-of select="$new_auth_alertname" disable-output-escaping="yes" /></div></div>
                  
                    <input type="text" id="fname" name="fname"/>
                    <div class="zag_a">E-mail  <div class="zag_a" id="alert_3" style="display:none; color:#930;"><xsl:value-of select="$new_auth_alertemail" disable-output-escaping="yes" /></div>
                    <div class="zag_a" id="alert_4" style="display:none; color:#930;"><xsl:value-of select="$new_auth_invalidmail" disable-output-escaping="yes" /></div></div>
                    <input type="text" id="email" size="50"  name="email"/>
                    <div class="zag_a">Телефон </div>
                    <input type="text" id="phoneCB" name="phoneCB"/>
                    <input type="hidden" name="ID_PointSales" value="{document(concat('uobject://',/result/user/@id))//property[@name='businesscenter_id']/value}" />
                    <input type="hidden" name="ID_Manager" value="{/result/user/@id}" />
                    <input type="hidden" name="lang" value="{$pre_lang}" />
					 <br/> <br/>
					 <img src="/i/bg/{$new_auth_img3}" id="submit_mail" />
                    </form>
		</xsl:when>
		<xsl:otherwise>
			Доступ запрещен
		</xsl:otherwise>
	</xsl:choose>
	
</xsl:template>
<!-- / Стартовая страница менеджера -->

<!-- Отчет по оплатам  менеджера -->
<xsl:template match="page[@id='60497']" >
<xsl:variable name="is_manager" select="document('udata://emarket/is_manager_login/')//is_manager" />
<xsl:variable name="PointSales" select="document(concat('uobject://',/result/user/@id))//property[@name='businesscenter_id']/value" />
	<xsl:choose>
		<xsl:when test="$is_manager = '1'">
		Точка продаж: <xsl:value-of select="$PointSales" />
		<xsl:variable name="allsumm" select="document(concat('udata://emarket/getting_cash/', $PointSales,'/'))" />
 		<h1>Полученные денежные средства.</h1>
 		
 		<b>Дата генерации отчета: </b> <xsl:value-of select="$allsumm//date_doc" />
 		<table width="100%" class="tbl_cb" cellpadding="3" cellspacing="3">
 		<tr>
 			<th>Дата \ Время</th>
 			<th>Id doc</th>
 			<th>Клиент </th>
 			<th>Тип платежа </th>
 			<th>Сумма</th>
 		</tr>
 	
 			<xsl:for-each select="$allsumm//item"> 
 				<tr align="center">
 				<td align="center" ><xsl:value-of select="DATE" /></td>
 				<td align="center" width="10"><xsl:value-of select="id_doc" /></td>
 				<td align="center"><xsl:value-of select="name" /></td>
 				<td align="center" width="50"><xsl:value-of select="type" /></td>
 				<td align="center"><xsl:value-of select="SUMM" /></td>
 				</tr>
 			</xsl:for-each>	
 		<tr>
 		<td></td><td></td><td><b>Итого:</b></td><td><xsl:value-of select="$allsumm//itog" /></td>
 		</tr>
 		<tr>
 		<td><b>Наличные Итог:</b></td><td><xsl:value-of select="$allsumm//nal_itog" /></td>
 		</tr>
 		<tr>
 		<td><b>Банковские карты Итог:</b></td><td><xsl:value-of select="$allsumm//beznal_itog" /></td>
 		</tr>
 		</table>	
 		
		 </xsl:when>
				<xsl:otherwise>
					Доступ запрещен
				</xsl:otherwise>
			</xsl:choose>
</xsl:template>
<!-- /Отчет по оплатам  менеджера -->

<!-- Отчет по заказам и оплатам getting_cash_orders61409 -->
<xsl:template match="page[@id='61409']" >
<xsl:variable name="is_manager" select="document('udata://emarket/is_manager_login/')//is_manager" />
<xsl:variable name="PointSales" select="document(concat('uobject://',/result/user/@id))//property[@name='businesscenter_id']/value" />

	<xsl:choose>
		<xsl:when test="$is_manager = '1'">
	Точка продаж: <xsl:value-of select="$PointSales" />
		<xsl:variable name="allsumm_orders" select="document(concat('udata://emarket/getting_cash_orders/', $PointSales,'/'))" />
 		<h1>Список заказов и оплаты</h1>
 		<table width="100%" class="tbl_cb" cellpadding="3" cellspacing="3">
 		<tr>
 			<th>Клиент</th>
 			<th>№ Заказа \ Документа</th>
 			<th>Баланс клиента</th>
 			<th>Точная сумма (Заказа\Отгрузки)</th>
 			<th>Остаток</th>
 		<!-- 	<th>Довнесения средств при получении </th>
 			<th>Остаток после доставки </th> -->
 			<th></th>
 			<th></th>
 		</tr>
 	
 			<xsl:for-each select="$allsumm_orders//item"> 
 				<tr align="center">
 				<td align="center"><xsl:value-of select="NAME" /></td>
 				<td align="center"><xsl:value-of select="ORDER" /></td>
 				<td align="center"><xsl:value-of select="BALANS" /></td>
 				<td align="center"><xsl:value-of select="EXACT_AMOUNT" /></td>
 				<td align="center"><xsl:value-of select="OSTATOK" /></td>
 				<!-- <td></td>
 				<td></td>-->
 				<td><input type='checkbox' name='$ORDER' value='ok' /></td>
 				</tr>
 			</xsl:for-each>	
 	
 		</table>
 		<br/>
 		<b>Точная сумма всех заказов:</b> <xsl:value-of select="$allsumm_orders//itog" />
		 </xsl:when>
				<xsl:otherwise>
					Доступ запрещен
				</xsl:otherwise>
			</xsl:choose>
</xsl:template>
<!-- /Отчет по заказам и оплатам 61409 -->

<xsl:param name="manager_successed_deposit" />

<!-- Страница пополнение депозита менеджером -->
<xsl:template match="page[@id='58153']" >
<xsl:if test="$manager_successed_deposit = 'ok'">
	<xsl:element name="script">
                        <xsl:attribute name="type">text/javascript</xsl:attribute>
                        <xsl:comment>
                            alert('Платеж успешно завершен.')
                        </xsl:comment>
                    </xsl:element>
</xsl:if>
<xsl:variable name="is_manager" select="document('udata://emarket/is_manager_login/')//is_manager" />
<xsl:choose>
	<xsl:when test="$is_manager = '1'">
<h1>Страница пополнения депозита.</h1>
<br/>

<form method="post" action="{$pre_lang}/emarket/manager_setdeposit/" id="pay_dep">
<input type="hidden" name="ID_PointSales" value="{document(concat('uobject://',/result/user/@id))//property[@name='businesscenter_id']/value}" />
<input type="hidden" name="ID_Manager" value="{/result/user/@id}" />

<b>Пополнить депозит для:</b>
				 	<!--  <select name="for_customer">
						<xsl:for-each select="document('udata://emarket/get_users_list/')//users_list/user"> 
							  
							<xsl:element name="option">
								<xsl:if test="@id = $selected_customer">
									<xsl:attribute name="selected">selected</xsl:attribute>
								</xsl:if>
								<xsl:attribute name="value"><xsl:value-of select="clientcode" /></xsl:attribute>
								<xsl:value-of select="lname" /><xsl:text> </xsl:text><xsl:value-of select="fname" /> (<xsl:value-of select="phone" />) - <xsl:text> : </xsl:text> <xsl:value-of select="email" />
							</xsl:element>
						
						</xsl:for-each>				
					</select>-->


			 <br/>Поиск клиента: <br/><input type="text" placeholder="" name="search_string" id="search_auto_deposit" value=""/>
			 <input class="auto_hiden" name='for_customer' value='' style="display:none;"/> 
					
					<br/><br/>
<b>На сумму:</b> <input type="text" id="depositValue" name="depositValue"  />
<select name="payType">
<option value="1">Наличными</option>
<option value="2">Безналичными</option>
</select>
<input type="submit" name="sub" value="Оплатить"  />
</form>
</xsl:when>
		<xsl:otherwise>
			Доступ запрещен
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>
<!-- / Страница пополнения депозита менеджером -->

<!-- Страница менеджера - просмотр оформленного заказа -->

<xsl:param name="manager_successed_order" />

<xsl:template match="page[@id='55433']" >
<xsl:variable name="is_manager" select="document('udata://emarket/is_manager_login/')//is_manager" />
	<xsl:choose>
		<xsl:when test="$is_manager = '1'">
			<xsl:choose>
				<xsl:when test="not($manager_successed_order)">
					Ошибка
				</xsl:when>
				<xsl:otherwise>		
					<!--<xsl:apply-templates select="document(concat('udata://emarket/order/',$manager_successed_order))/udata" mode="manager-succ-order"/>-->
					<xsl:apply-templates select="document(concat('uobject://',$manager_successed_order))/udata/object" mode="manager-succ-order"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		<xsl:otherwise>
			Доступ запрещен
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="object" mode="manager-succ-order">
			<xsl:element name="script">
				<xsl:attribute name="type">text/javascript</xsl:attribute>
				<xsl:comment>
					function printit(){ 
						if (window.print) {
							window.print(); 
							} else {
							var WebBrowser = '&lt;OBJECT ID="WebBrowser1" WIDTH=0 HEIGHT=0 CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"&gt;&lt;/OBJECT&gt;';
							document.body.insertAdjacentHTML('beforeEnd', WebBrowser);
							WebBrowser1.ExecWB(6, 2);//Use a 1 vs. a 2 for a prompting dialog box WebBrowser1.outerHTML = ""; 
						}
					}
				</xsl:comment>
			</xsl:element>
	<div style="width:215px;color:#000;">
     <div align="center" style="width:215px;">
     <p style="font-size:12px;color:#000;">
     	<font style="font-size:16px; font-weight:bold;color:#000;">"Le Bon Gout"</font><br/>
        <font style="font-size:16px; font-weight:bold;color:#000;">ЗАО "Ле Бон Гу"</font><br/>
        ИНН 7702740432<br/>
        г. Москва<br/>
        Большая Переяславская 46-1
        </p>
     </div>
     <p style="font-size:12px;color:#000;">
     Заказ от <xsl:value-of select="document(concat('udata://custom/dateru/', //property[@name='order_date']/value/@unix-timestamp))" /><br/>
     Дата доставки:  <xsl:value-of select="document(concat('udata://custom/dateru/', //property[@name='delivery_allow_date']/value/@unix-timestamp))" /> 18:00<br/>
     Номер заказа: <b><font style="font-size:16px;color:#FF0000">01-01-<xsl:value-of select="//property[@name='number']/value" /></font></b><br/>
     Примечание:
     <xsl:value-of select="//property[@name='favorite_comment']/value" /><br/>
     </p>
     <strong>Наименование товаров:</strong>
     <div style="font-size:12px; border-top:1px dashed black; border-bottom: 1px dashed black;">
     	<xsl:variable name="deliv_type" select="//property[@name='delivery_type']/value" />
	
	<!--<xsl:for-each select="document(concat('udata://emarket/manager_sucessed_order_cart/?o_id=',@id))//items/page">-->
	
	<xsl:variable name="o_id" select="@id" />
<ol>
	<xsl:for-each select="document(concat('udata://emarket/manager_sucessed_order_cart/?o_id=',$o_id))//items/page" >
          <xsl:sort order="ascending"  select="@delivery_date" /> 
				<xsl:if test="$deliv_type = 'step_by_step'">
                   <!-- Выводим заголовок-дату для первого элемента -->
                   <xsl:if test="position() = 1">
                        <div style="color:#999999;">
							Заказ:<xsl:value-of select="@order_number" /><xsl:text> </xsl:text>Доставка:<xsl:value-of select="document(concat('udata://custom/dateru/', @delivery_date))" />
                        </div>
                   </xsl:if>
                   
                    <!-- Сохраняем в переменные текущие значения для цикла --> 
                    <xsl:variable name="tmp2" select="position()-1" />
                    <xsl:variable name="tmp3" select="@delivery_date" />
                    <!-- В новом цикле с такой же сортировкой ищем элемент с индексом -1 от текущего в родительском цикле -->
                    <xsl:for-each select="document(concat('udata://emarket/manager_sucessed_order_cart/?o_id=',$o_id))//items/page">
                    <xsl:sort order="ascending" select="@delivery_date" />
                    <!-- Если предыдущий элемент имел другую дату доставки, то выводим новый заголовок-дату-->
                        <xsl:if test="(position() = $tmp2) and (@delivery_date != $tmp3)">
							<div style="color:#999999;">
								Заказ:<xsl:value-of select="@order_number" /><xsl:text> </xsl:text>Доставка:<xsl:value-of select="document(concat('udata://custom/dateru/', $tmp3))" />
							</div>
                        </xsl:if>
                    </xsl:for-each>
				</xsl:if>
	
		<!--<xsl:if test="$deliv_type = 'step_by_step'">
			<xsl:if test="(position()=1) or ()">
				Заказ:<xsl:value-of select="@order_number" /><xsl:text> </xsl:text>Доставка:<xsl:value-of select="document(concat('udata://custom/dateru/', @delivery_date))" />
			</xsl:if>
		</xsl:if>-->
	
		<li>
			<xsl:variable name="units" select="document(concat('upage://', @id))//property[@name='unit']/value" disable-output-escaping="yes" />
			<xsl:variable name="new_prod_units">
				<xsl:choose>
					<xsl:when test="$pre_lang = '/fr'">
						<xsl:choose>
							<xsl:when test="$units = 'шт'">
								<xsl:value-of select="$new_thing" disable-output-escaping="yes" />
							</xsl:when>
							<xsl:when test="$units = 'упак'">
								<xsl:value-of select="$new_pack" disable-output-escaping="yes" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$units" disable-output-escaping="yes" />
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$pre_lang = '/en'">
						<xsl:choose>
							<xsl:when test="$units = 'шт'">
								<xsl:value-of select="$new_thing" disable-output-escaping="yes" />
							</xsl:when>
							<xsl:when test="$units = 'упак'">
								<xsl:value-of select="$new_pack" disable-output-escaping="yes" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$units" disable-output-escaping="yes" />
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
					   <xsl:value-of select="$units" disable-output-escaping="yes" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:choose>
				<xsl:when test="$pre_lang = '/fr'">
					<xsl:value-of select="document(concat('upage://', @id))//property[@name='shortname_fr']/value"  disable-output-escaping="yes"  />
				</xsl:when>
				<xsl:when test="$pre_lang = '/en'">
					<xsl:value-of select="document(concat('upage://', @id))//property[@name='shortname_en']/value"  disable-output-escaping="yes"  />
				</xsl:when>
				<xsl:otherwise>
				   <xsl:value-of select="document(concat('upage://', @id))//property[@name='shortname']/value"  disable-output-escaping="yes"  />
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>, </xsl:text>
					
				   <xsl:text> </xsl:text><span id="manager_edit_inp_{@id}"><xsl:value-of select="amount" disable-output-escaping="" /></span>
				  
					 <xsl:choose>
					 <xsl:when test="(amount  >= 200) or ($units = 'кг')">
						<xsl:text> </xsl:text><xsl:value-of select="$new_gr" />.           
					 </xsl:when>
					 <xsl:otherwise>
						<xsl:text> </xsl:text><xsl:value-of select="$new_prod_units" disable-output-escaping="yes" />
					 </xsl:otherwise>
					 </xsl:choose>
					 <span> | </span>
					 
			<xsl:variable name="cena" select="item_price" />
				  
				  <xsl:choose>
					<xsl:when test="$units = 'кг'">
						<xsl:value-of select="$cena * 1000" disable-output-escaping="yes" /><xsl:text> </xsl:text><xsl:value-of select="$new_rub" disable-output-escaping="yes" />/<xsl:value-of select="$new_kg" disable-output-escaping="yes" />
					</xsl:when>
					<xsl:otherwise>
						  <xsl:value-of select="round($cena)" disable-output-escaping="yes" /><xsl:text> </xsl:text><xsl:value-of select="$new_rub" disable-output-escaping="yes" />/<!--<xsl:value-of select="properties/property[@name='unit']/value" disable-output-escaping="yes" />-->
						  <xsl:value-of select="$new_prod_units" />
					</xsl:otherwise>
				  </xsl:choose>

					<xsl:text> Итого:</xsl:text><xsl:value-of select="price" /><xsl:text> </xsl:text><xsl:value-of select="$new_rub" disable-output-escaping="yes" />
					<xsl:if test="cutting = '1'">
						Необходимо нарезать
					</xsl:if>
		</li>
	</xsl:for-each>
</ol>
     
     </div>
     <p style="font-size:12px;color:#000;">
     <strong>Итого к оплате: <xsl:value-of select="document(concat('udata://emarket/manager_sucessed_order_cart/?o_id=',@id))//summary" /><xsl:text> </xsl:text><xsl:value-of select="$new_rub" disable-output-escaping="yes" /></strong>
     </p>
     <div align="center" style="width:215px;">
    <p style="font-size:12px;color:#000;">
     	Уважаемый покупатель! Если у вас есть вопросы по работе магазина, просим обращаться в службу клиентской поддержки пн-сб<br /> 
        с 09:00 до 21:00<br/>
        по телефону (495) 663-88-16
        www.lebongout.ru
        </p>  
     </div>
    </div>
	<br/><br/><button class="btn-print" onclick="printit()">Печать</button>
</xsl:template>

<!-- / Страница менеджера - просмотр оформленного заказа -->
<!-- Страница менеджера - добавление заказа -->

<xsl:param name="selected_customer" />

<xsl:template match="page[@id='54271']" >
<xsl:variable name="is_manager" select="document('udata://emarket/is_manager_login/')//is_manager" />

	<xsl:choose>
		<xsl:when test="$is_manager = '1'">
			
			<xsl:element name="script">
				<xsl:attribute name="type">text/javascript</xsl:attribute>
				<xsl:comment>
					function managerPutProduct(shtrix){					
						$.ajax({
						  url: "/udata/emarket/get_product_by_shtrix/?shtrix="+shtrix,
						  async: true,
						  cache: false,
						  complete: function(msg){
						  //strRe = "^[0-9]$";
						  //re = new RegExp(strRe);
						  //var s = msg.responseText;
						  //alert(s.match(re))
						  if (msg.responseText == "") return; var ob = document.getElementById('order_basket'); ob.innerHTML += msg.responseText+"\n"}
						});
					}
				</xsl:comment>
			</xsl:element>
			

			
			<a href="/manager_start_page/">Стартовая страница менеджера</a>-><h1>Добавить заказ</h1>
			Добавить товар (Вставьте штрихкоды каждый с переносом строки)
    
	
    
    
			<form method="post" action="/emarket/manager_add_basket/">
				<textarea id="order_basket" name="order_basket" rows="18" cols="25">
				</textarea><br/>
					<br/>
					<!--<select name="for_customer">
						<xsl:for-each select="document('udata://emarket/get_users_list/')//users_list/user"> 
							
							<xsl:element name="option">
								<xsl:if test="@id = $selected_customer">
									<xsl:attribute name="selected">selected</xsl:attribute>
								</xsl:if>
								<xsl:attribute name="value"><xsl:value-of select="@id" /></xsl:attribute>
								<xsl:value-of select="lname" /><xsl:text> </xsl:text><xsl:value-of select="fname" /> (<xsl:value-of select="phone" />) - <xsl:text> : </xsl:text> <xsl:value-of select="email" />
							</xsl:element>
						
						</xsl:for-each>				
					</select>-->

			 Поиск клиента: <br/><input type="text" placeholder="" name="search_string" id="search_auto" value=""/>
			 <input class="auto_hiden" name='for_customer' value='{$selected_customer}' style="display:none;"/>
			 <xsl:if test="$selected_customer">
			 	Клиент выбран: <xsl:value-of select="$selected_customer" />
			 </xsl:if>
               
					 <!-- <input type="checkbox" name="user_cb" value="yes" /> Показывать только пользователей CyberShop  -->
				<br/><br/>
			<img alt="Сохранить" style="cursor:pointer" onclick="this.parentNode.submit()" src="/i/bg{$pre_lang}/save.png" />
			</form>
	
	
	
	
		</xsl:when>
		<xsl:otherwise>
			Доступ запрещен
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>
<!--
<xsl:template match="user" mode="dynamic-sel" >
	<xsl:element name="option">
		<xsl:attribute name="value"><xsl:value-of select="@id" /></xsl:attribute>
		<xsl:value-of select="nick" />" - (<xsl:value-of select="fname" /><xsl:text> </xsl:text><xsl:value-of select="lname" /><xsl:text> : </xsl:text>)<xsl:value-of select="email" />
	</xsl:element>
</xsl:template>-->
<!-- / страница менеджера - добавление заказа -->


<!-- страница менеджера - подтверждение заказа -->
<xsl:template match="page[@id='54479']" >
<xsl:variable name="is_manager" select="document('udata://emarket/is_manager_login/')//is_manager" />

	<xsl:choose>
		<xsl:when test="$is_manager = '1'">
		
		<h1>
			Добавить товары:
		</h1>
		
		<form method="post" action="/emarket/manager_plus_basket/">
			<textarea id="order_basket" name="order_basket" rows="18" cols="25">
			</textarea><br/>
			<img alt="Сохранить" style="cursor:pointer" onclick="this.parentNode.submit()" src="/i/bg{$pre_lang}/save.png" />
		</form>
		
		<form method="post" id="manager_commit_form" action="/emarket/manager_purchase_order_4_customer/">
		<h1>
			Оформить заказ для:
		</h1>
		
		<xsl:variable name="selected_customer" select="document('udata://emarket/manager_get_order_for_customer/')//for_customer" />
		<xsl:variable name="customer_prop" select="document(concat('uobject://', $selected_customer))" />
		<xsl:variable name="fi_customer" select="concat($customer_prop//property[@name='lname']/value,' ', $customer_prop//property[@name='fname']/value)" />
<!--  	<select name="for_customer">
				<xsl:variable name="selected_customer" select="document('udata://emarket/manager_get_order_for_customer/')//for_customer" />;
				
				<xsl:for-each select="document('udata://emarket/get_users_list/')//users_list/user"> 
					<xsl:element name="option">
						<xsl:if test="@id = $selected_customer">
							<xsl:attribute name="selected">selected</xsl:attribute>
						</xsl:if>
						<xsl:attribute name="value"><xsl:value-of select="@id" /></xsl:attribute>
						<xsl:value-of select="lname" /><xsl:text> </xsl:text><xsl:value-of select="fname" /> (<xsl:value-of select="phone" />) - <xsl:text> : </xsl:text> <xsl:value-of select="email" />
					</xsl:element>
				</xsl:for-each>				
			</select>
   -->
  			 <xsl:if test="$selected_customer">
			 	Выбранный клиент: <xsl:value-of select="$selected_customer" />
			 </xsl:if>
   			 <br/> <br/><input type="text" placeholder="" name="search_string" id="search_auto" value="{$fi_customer}"/>
			 <input class="auto_hiden" name='for_customer' value='{$selected_customer}' style="display:none;"/>
			 
   
        <h1>Выбранный товар:</h1>
        
        <br/>
            <!-- <input type="radio" name="delivery_date_type" value="step_by_step" /><xsl:value-of select="$new_delivery_step_by_step" /><br/><br/> -->
           
            <!--<xsl:apply-templates select="document('udata://emarket/cart/')//page" mode="maybe-date"/>-->
            
			<xsl:for-each select="document('udata://emarket/manager_cart_pages/')//items/page" >
           <!-- <xsl:sort order="ascending"  select="document(concat('upage://', @id))//property[@name = 'datep']/value/@unix-timestamp" />-->
           <xsl:sort order="ascending"  select="datep/@unix-timestamp" />
               <!-- <xsl:if test="count(document(concat('upage://', @id))//property[@name = 'datep']) &gt; 0" >-->
                   <!-- Выводим заголовок-дату для первого элемента -->
               <!--    <xsl:if test="position() = 1">
                        <div style="color:#999999;">
                        <xsl:value-of select="document(concat('udata://custom/dateru/', datep/@unix-timestamp))" />
                        </div>
                   </xsl:if>-->
                   
                    <!-- Сохраняем в переменные текущие значения для цикла --> 
                   <!--  <xsl:variable name="tmp2" select="position()-1" />
                    <xsl:variable name="tmp3" select="datep/@unix-timestamp" /> -->
                    <!-- В новом цикле с такой же сортировкой ищем элемент с индексом -1 от текущего в родительском цикле -->
                  <!--   <xsl:for-each select="document('udata://emarket/cart_pages/')//items/page">
                    <xsl:sort order="ascending"  select="datep/@unix-timestamp" /> -->
                    <!-- Если предыдущий элемент имел другую дату доставки, то выводим новый заголовок-дату-->
                    <!--     <xsl:if test="(position() = $tmp2) and (datep/@unix-timestamp != $tmp3)">
                        <div style="color:#999999;">
                            <xsl:value-of select="document(concat('udata://custom/dateru/', $tmp3))" />
                            </div>
                        </xsl:if>
                    </xsl:for-each> -->

                    <!--<xsl:value-of select="document(concat('udata://custom/dateru/', document(concat('upage://', @id))//property[@name = 'datep']/value/@unix-timestamp))" />
                    <xsl:text> - </xsl:text>-->
                    <table border="0" cellpadding="5" cellspacing="5" class="emarketAloowDateTovar">
                    <tr>
                    <td>
            		<a href="{$pre_lang}/emarket/basket/remove/element/{@id}/{$lite_q}"><img src="/images/cms/field_delete.png" alt="Удалить товар" /></a>
                    </td>
                    <td>
                    <xsl:element name="img">
                    	<xsl:attribute name="src">
                        	<xsl:value-of select="document(concat('upage://', @id))//property[@name = 'photo']/value" />
                        </xsl:attribute>
                        <xsl:attribute name="width">60px</xsl:attribute>
                        <xsl:attribute name="height">60px</xsl:attribute>
                    </xsl:element>
                    </td>
                    <td>
                     <!-- <xsl:choose>
                        <xsl:when test="$pre_lang = '/fr'">
                            <xsl:value-of select="document(concat('upage://', @id))//property[@name = 'shortname_fr']/value"  disable-output-escaping="yes"  />
                        </xsl:when>
                        <xsl:when test="$pre_lang = '/en'">
                            <xsl:value-of select="document(concat('upage://', @id))//property[@name = 'shortname_en']/value"  disable-output-escaping="yes"  />
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:value-of select="document(concat('upage://', @id))//property[@name = 'shortname']/value"  disable-output-escaping="yes"  />
                        </xsl:otherwise>
                    </xsl:choose>--> 
					
						<xsl:apply-templates select="cart_page" mode="managers-cart" />
					
                    </td>
                    </tr></table>
                    <br/>
        		<!--</xsl:if>-->
                
            </xsl:for-each>
			<br/>
			<h1>Итого за весь заказ:</h1> <xsl:value-of select="document('udata://emarket/cart/')//summary/price/actual" /><xsl:text> </xsl:text><xsl:value-of select="$new_rub" />
            <br/>
            <br/>
            <!-- <input type="radio" name="delivery_date_type" value="fully" /><xsl:value-of select="$new_delivery_fully" /><br/> -->
            
            <!--<xsl:for-each select="document('udata://emarket/cart_pages/')//items/page">         
                <xsl:sort select="datep/@unix-timestamp" order="descending" />
                     
                <xsl:if test="position()=1">
                    <div style="color:#999999;"><br/>
                        <xsl:value-of select="document(concat('udata://custom/dateru/', datep/@unix-timestamp))"/> 
                        
                <xsl:element name="input">
                    <xsl:attribute name="type">hidden</xsl:attribute>
                    <xsl:attribute name="name">max_order_date</xsl:attribute>
                    <xsl:attribute name="value">
                    	<xsl:value-of select="datep/@unix-timestamp"/> 
                    </xsl:attribute>
                </xsl:element>
                        
                    </div>
                	<span style="display:none" id="max_datep"><xsl:value-of select="document(concat('udata://custom/dateru2/', datep/@unix-timestamp))"/></span>
                </xsl:if>       
            </xsl:for-each>-->
			<span style="display:none" id="max_datep"><xsl:value-of select="document('udata://emarket/manager_get_min_delivery_date/')/min_date"/></span>
            <br/>
            <br/>
            <input type="radio" id="delivery_date_type" name="delivery_date_type" value="by_hand" checked="checked" />Введите дату доставки <br/><br/>
            <div>
            	<xsl:variable name="tmp_script">
                ma=document.getElementById('max_datep').innerHTML;if((ma &gt; this.value)) alert('<xsl:value-of select="$new_msg_invalid_delivery_date"/>');if((ma &gt; this.value)) this.value=''
                </xsl:variable>
            	<!--<input type="text" id="datepicker" name="hand_writed_date" value="" class="textinputs" readonly="readonly" onchange="ma=document.getElementById('max_datep').innerHTML;if((ma &gt; this.value)) alert('Доставка на выбранную дату невозможна');if((ma &gt; this.value)) this.value=''" />-->
                <input type="text" id="datepicker" name="hand_writed_date" value="" class="textinputs" readonly="readonly" onchange="{$tmp_script}" />
            </div>
			<br/>
            <br/>
            <!--<h1>
				<xsl:value-of select="$new_delivery_interval" />:
			</h1>
            <xsl:apply-templates select="document('udata://emarket/getDeliveryIntervals/')//item" mode="delivery-intervals" /> 
			<br/> -->
			
			<!-- типы 783 и 784 -->
			<!--
			<xsl:apply-templates select="document('udata://emarket/getGuideItemsById/?guideId=783')//items" mode="delivery-choose" />
			<xsl:apply-templates select="document('udata://emarket/getGuideItemsById/?guideId=784')//items" mode="delivery-choose" />-->
			<input name="delivery-id" type="hidden" value="100159" />
			
			<!-- Выбор адреса доставки  -->
            <div id="select-addr-block" style="display:none;" >
            <label>
                <input type="radio" id="delivery-address-old-cb" value="old" onchange="$('#delivery-address-old').show('200'); if (this.checked!='') document.getElementById('delivery-address-new-cb').checked='';"/>
            <xsl:value-of select="$new_delivery_old_address" />
            </label>
                <!--<xsl:apply-templates select="items" mode="delivery-address" /> -->
                    <xsl:apply-templates select="document('udata://emarket/cAdressesList/')//items" mode="delivery-address" />
                <br/> 
                <br/>
            </div>
            <!-- / Выбор адреса доставки-->
			<br/>
			
			 <xsl:value-of select="$new_order_comment" /><xsl:text>:  </xsl:text><input type="text" name="favorite_comment" value="" class="textinputs" /><br/><br/>
			
			<br/><br/><br/>
				<img alt="Продолжить" style="cursor:pointer" onclick="var iform = document.getElementById('manager_commit_form');iform.submit()" src="/i/bg{$pre_lang}/stepnext.png" />
            </form>
	
		</xsl:when>
		<xsl:otherwise>
			Доступ запрещен
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>
<!-- / страница менеджера - подтверждение заказа -->


 <!-- Пункт корзины менеджера -->
 <xsl:template match="cart_page" mode="managers-cart">
 
 <xsl:variable name="units" select="document(concat('upage://', @id))//property[@name='unit']/value" disable-output-escaping="yes" />
<xsl:variable name="new_prod_units">
    <xsl:choose>
        <xsl:when test="$pre_lang = '/fr'">
            <xsl:choose>
                <xsl:when test="$units = 'шт'">
                    <xsl:value-of select="$new_thing" disable-output-escaping="yes" />
                </xsl:when>
                <xsl:when test="$units = 'упак'">
                    <xsl:value-of select="$new_pack" disable-output-escaping="yes" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$units" disable-output-escaping="yes" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:when>
        <xsl:when test="$pre_lang = '/en'">
            <xsl:choose>
                <xsl:when test="$units = 'шт'">
                    <xsl:value-of select="$new_thing" disable-output-escaping="yes" />
                </xsl:when>
                <xsl:when test="$units = 'упак'">
                    <xsl:value-of select="$new_pack" disable-output-escaping="yes" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$units" disable-output-escaping="yes" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
           <xsl:value-of select="$units" disable-output-escaping="yes" />
        </xsl:otherwise>
    </xsl:choose>
</xsl:variable>
 
 
	      <table width="92%"><tr><td>
		  <!--<xsl:value-of select="document(concat('upage://', page/@id))//property[@name='unit']/value" disable-output-escaping="yes" />-->
		  <span><a class="sfa_cart">
          <!--<xsl:value-of select="document(concat('upage://', page/@id))//property[@name='shortname']/value" disable-output-escaping="yes" />-->
           <xsl:choose>
                <xsl:when test="$pre_lang = '/fr'">
                    <xsl:value-of select="document(concat('upage://', @id))//property[@name='shortname_fr']/value"  disable-output-escaping="yes"  />
                </xsl:when>
                <xsl:when test="$pre_lang = '/en'">
                    <xsl:value-of select="document(concat('upage://', @id))//property[@name='shortname_en']/value"  disable-output-escaping="yes"  />
                </xsl:when>
                <xsl:otherwise>
                   <xsl:value-of select="document(concat('upage://', @id))//property[@name='shortname']/value"  disable-output-escaping="yes"  />
                </xsl:otherwise>
            </xsl:choose><br/><xsl:text>Штрих-код: </xsl:text><xsl:value-of select="document(concat('upage://', @id))//property[@name='bar_code']/value"  disable-output-escaping="yes"  /><br/>
   
          </a></span>
          <!--РАЗБОР ПОЛЕТОВ С ЦЕНАМИ -->
              <em>
			  
			  <xsl:variable name="cena" select="document(concat('upage://', @id))//property[@name='price']/value" />
			  
			  <xsl:choose>
				<xsl:when test="document(concat('upage://', @id))//property[@name='unit']/value = 'кг'">
					<xsl:value-of select="$cena * 1000" disable-output-escaping="yes" /><xsl:text> </xsl:text><xsl:value-of select="$new_rub" disable-output-escaping="yes" />/<xsl:value-of select="$new_kg" disable-output-escaping="yes" />
				</xsl:when>
				<xsl:otherwise>
					  <xsl:value-of select="round($cena)" disable-output-escaping="yes" /><xsl:text> </xsl:text><xsl:value-of select="$new_rub" disable-output-escaping="yes" />/<!--<xsl:value-of select="properties/property[@name='unit']/value" disable-output-escaping="yes" />-->
					  <xsl:value-of select="$new_prod_units" />
				</xsl:otherwise>
			  </xsl:choose>
			  
			  
			  
			  
                <xsl:text> Итого:</xsl:text><xsl:value-of select="round(document(concat('upage://', @id))//property[@name='price']/value * amount)" /><xsl:text> </xsl:text>
                 <xsl:choose>
                    <xsl:when test="$pre_lang = '/fr'">
                        <xsl:choose>
                            <xsl:when test="price/@suffix = 'руб'">
                                <xsl:value-of select="$new_rub" disable-output-escaping="yes" />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="price/@suffix" disable-output-escaping="yes" />
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:when test="$pre_lang = '/en'">
                        <xsl:choose>
                            <xsl:when test="price/@suffix = 'руб'">
                                <xsl:value-of select="$new_rub" disable-output-escaping="yes" />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="price/@suffix" disable-output-escaping="yes" />
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                       <xsl:value-of select="price/@suffix"  disable-output-escaping="yes"  />
                    </xsl:otherwise>
            	 </xsl:choose>
              </em>
         </td></tr></table>
                <div class="cart_edit_{@id}" style="float: none; padding-top:3px; width: 92%; vertical-align:middle !important;padding-bottom:0px;" id="cart_edit_{@id}"><table border="0" width="100%" height="19px"><tr style="height:19px; width:19px; vertical-align:middle;"><td style="height:19px; width:19px; vertical-align:middle;">
                
                <xsl:variable name="stv" select="document(concat('upage://', @id))//property[@name='stv']/value" disable-output-escaping="yes" />
                
                <!-- <xsl:choose>
                    <xsl:when test="$stv = 1">	
                    	<xsl:variable name="ves_one" select="document(concat('upage://', @id))//property[@name='weight_stuka']/value * 1000" disable-output-escaping="yes" /> 
                    	<xsl:element name="a">
                        	<xsl:attribute name="style">vertical-align:middle;</xsl:attribute>
                            <xsl:attribute name="class">sfa_cart</xsl:attribute>
                            <xsl:attribute name="href">
                            javascript:sfa_cart_amount2('<xsl:value-of select="@id" />', false, '<xsl:value-of select="$ves_one" />', 'manager_edit_inp_<xsl:value-of select="@id" />', true);
                            </xsl:attribute>
                            <img alt="-" src="/i/icons/a_del.png" style="vertical-align:middle;" />
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise > -->
                        <xsl:element name="a">
                        	<xsl:attribute name="style"> vertical-align:middle;</xsl:attribute>
                            <xsl:attribute name="class">sfa_cart</xsl:attribute>
                            <xsl:attribute name="href">javascript:sfa_cart_amount('<xsl:value-of select="@id" />', 'manager_edit_inp_<xsl:value-of select="@id" />', false, '<xsl:value-of select="document(concat('upage://', @id))//property[@name='unit']/value" disable-output-escaping="yes" />', true);</xsl:attribute>
                            <img alt="-" src="/i/icons/a_del.png" style="vertical-align:middle;" />
                        </xsl:element>
                   <!--  </xsl:otherwise>
                 </xsl:choose>-->
      
               <!-- <a href="javascript:sfa_cart_amount('{$pageID}', 'card_edit_inp_{@id}', false, '{$unitsLocalVar}');"><img alt="-" src="/i/icons/a_del.png" /></a>-->
               
                <!--<input class="sfa_inp" type="text" id="card_edit_inp_{@id}" value="{amount}" readonly="readonly" />-->
                <span id="min_ves_{@id}" style="display:none;"><xsl:value-of select="document(concat('upage://', @id))//property[@name='min_weight']/value * 1000" disable-output-escaping="yes" /></span>
                <span style="vertical-align:middle;width:* !important; float:none !important; height:19px;">
               <xsl:text> </xsl:text><span id="manager_edit_inp_{@id}" style="width:* !important; float:none !important;" ><xsl:value-of select="amount" disable-output-escaping="" /></span>
               <!-- <a href="javascript:sfa_cart_amount('{$pageID}', 'card_edit_inp_{@id}', true, '{$unitsLocalVar}');"><img alt="+" src="/i/icons/a_add.png" /></a>-->
                <!--РАЗБОР ПОЛЕТОВ С ЕДИНИЦАМИ ИЗМЕРЕНИЙ --> 
              
                 <xsl:choose>
		         <xsl:when test="(amount  >= 200) or (document(concat('upage://', @id))//property[@name='unit']/value = 'кг')">
                 	<!--<span id="card_edit_inp_{@id}"><xsl:value-of select="amount" disable-output-escaping="" /></span>--><xsl:text> </xsl:text><xsl:value-of select="$new_gr" />.           
                 </xsl:when>
                 <xsl:otherwise>
                    <!--<xsl:value-of select="document(concat('upage://', page/@id))//property[@name='unit']/value" disable-output-escaping="yes" />-->
                  <!-- <span id="card_edit_inp_{@id}"><xsl:value-of select="amount" disable-output-escaping="" /></span>--><xsl:text> </xsl:text><xsl:value-of select="$new_prod_units" disable-output-escaping="yes" />
                 </xsl:otherwise>
                 </xsl:choose>
                 </span>
                  <xsl:text> </xsl:text>
                 <!-- <xsl:choose>
                    <xsl:when test="$stv = 1">	
                    	<xsl:variable name="ves_one" select="document(concat('upage://', @id))//property[@name='weight_stuka']/value * 1000" disable-output-escaping="yes" />
                        <xsl:element name="a">
                        <xsl:attribute name="style">vertical-align:middle;</xsl:attribute>
                        <xsl:attribute name="class">sfa_cart</xsl:attribute>
                    	<xsl:attribute name="href">
                        	javascript:sfa_cart_amount2('<xsl:value-of select="@id" />', true, '<xsl:value-of select="$ves_one" />', 'manager_edit_inp_<xsl:value-of select="@id" />', true);
                        </xsl:attribute>
                        <img alt="-" src="/i/icons/a_add.png" style="vertical-align:middle;" />
                    </xsl:element>
                    </xsl:when>
                    <xsl:otherwise>-->
                    <xsl:element name="a">
                    	<xsl:attribute name="style">vertical-align:middle;</xsl:attribute>
                        <xsl:attribute name="class">sfa_cart</xsl:attribute>
                    	<xsl:attribute name="href">javascript:sfa_cart_amount('<xsl:value-of select="@id" />', 'manager_edit_inp_<xsl:value-of select="@id" />', true, '<xsl:value-of select="document(concat('upage://', @id))//property[@name='unit']/value" disable-output-escaping="yes" />', true);</xsl:attribute>
                        <img alt="-" src="/i/icons/a_add.png" style="vertical-align:middle;" />
                    </xsl:element>
                   <!--  </xsl:otherwise>
                  </xsl:choose>
                -->
		       <!-- <a class="sfa_cart" href="javascript:sfa_cart_add('{$pageID}', 'card_edit_inp_{@id}');"> Сохранить</a> / -->
               </td></tr></table>
		  	  </div>
              
              <xsl:if test="document(concat('udata://emarket/is_narezka/?typeId=', page/@type-id))//narezka[text()='yes']">
                  <xsl:element name="input">
                 	<xsl:attribute name="type">checkbox</xsl:attribute>
                    <xsl:attribute name="id">manager_card_narezka_<xsl:value-of select="@id"/></xsl:attribute>
                    <xsl:attribute name="onclick">toggle_narezka('<xsl:value-of select="@id"/>', true)</xsl:attribute>
                    <xsl:if test="count(document(concat('uobject://', @object-id))//property[@name='item_cutting']/value) &gt; 0">
                        <xsl:attribute name="checked">
                                checked
                        </xsl:attribute>
                    </xsl:if>
                 </xsl:element>
                       
                 <xsl:text> </xsl:text><xsl:value-of select="$new_cart_cut" />
               </xsl:if>
 </xsl:template> 
 <!-- / Пункт корзины менеджера -->

 <!-- Список заказов менеджера -->
 <xsl:template match="page[@id='55434']" >
<xsl:variable name="is_manager" select="document('udata://emarket/is_manager_login/')//is_manager" />
	<xsl:choose>
		<xsl:when test="$is_manager = '1'">
			<table width="100%" border="1" class='tbl_cb'>
			<tr align="center">
			<th>Заказ №</th><th>Дата</th><th>Для покупателя</th><th>Статус</th><th>Доставлен</th>
			</tr>
			<xsl:apply-templates select="document('udata://emarket/manager_orders_list/')//order" mode="manager-orders-list" />
			</table>
		</xsl:when>
		<xsl:otherwise>
			Доступ запрещен
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="order" mode="manager-orders-list">
	<xsl:if test="document(concat('uobject://', status_id))//object/@name != 'Выполнен'">
	<tr>
	<td><b><xsl:value-of select="number" /></b></td>
	<td><xsl:value-of select="document(concat('udata://custom/dateru/', @delivery_date))"/></td>
	<td>[<b><span style="padding-right:5px;"><xsl:value-of select="document(concat('uobject://', for_customer))//property[@name='e-mail']/value" /></span></b>]
		<span style="padding-right:5px;"><xsl:value-of select="document(concat('uobject://', for_customer))//property[@name='lname']/value" /></span>
	    <span style="padding-right:5px;"><xsl:value-of select="document(concat('uobject://', for_customer))//property[@name='fname']/value" /></span>
	</td>
	<td><xsl:value-of select="document(concat('uobject://', status_id))//object/@name" /></td>
	<td align="center">
	<form name="{number}" method="post" action="/emarket/manager_setstatus/">
	<!-- <input type="hidden" name="status_id" value="{status_id}" />  -->
	<input type="hidden" name="o_customer" value="{for_customer}" />
	<input type="hidden" name="o_id" value="{@id}" />
	<input type="hidden" name="o_number" value="{number}" />
	<input type="submit" name="done" value="Доставлен"/>
	</form>
	</td>
	</tr>
	</xsl:if>
</xsl:template>

 <!-- / Список заказов менеджера -->

</xsl:stylesheet>