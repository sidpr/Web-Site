<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:php="http://php.net/xsl" extension-element-prefixes="php">
<!-- Переменная хранит строку с номерами избранных продуктов для клиента, так как на главной странице не передается инфа о пользователе, другим способом получить не представляется позможным -->
<!--<xsl:variable name="combinedFavProducts" select="//user//property[@name='favorite_products']/combined" />-->
<xsl:variable name="combinedFavProducts" select="document(concat('uobject://', $userIdVar))//property[@name='favorite_products']/combined" />
<!-- Переменная хранит строку со списко наименований разделов, цену в которых необходио выводить за 100граммов, а не за КГ -->
<xsl:variable name="ProductCatrgoryPo100gramm" >,orehi_i_semena,orehi,myasnaya_gastronomiya,syry,suhofrukty,shokolad,pechen_e,konfety,</xsl:variable>
<xsl:param name="super" /> <!-- вывод каталога с блочным кешем -->
<!-- каталог -->
<xsl:template match="page[@type-id='9']" >
    <xsl:value-of select=".//property[@name = 'content']/value" disable-output-escaping="yes" />
    <xsl:variable name="index" select="//page/@parentId" disable-output-escaping="yes" />

	<!-- подкатегории -->
    <xsl:if test="$index != 0">
    <table border="0" width="100%" height="110px"><tbody><tr><td id="subcats">
    <xsl:choose>
    	<xsl:when test="string-length(translate(attribute::link,'/_abcdefghijklmnopqrstuvwxyz', '/')) &gt; 3">
        	<!--<xsl:apply-templates select="document(concat('udata://catalog/getCategoryList/notemplate/',@parentId,'/10'))/udata/items/item" mode="catalog_subcat"/>-->
            <xsl:apply-templates select="document(concat('udata://custom/catalog_menu_lite_cache/?root=',@parentId))/udata/items/item" mode="catalog_subcat"/>
        </xsl:when>
    	<xsl:otherwise>
			<!--<xsl:apply-templates select="document(concat('udata://catalog/getCategoryList/notemplate/',@id,'/10'))/udata/items/item" mode="catalog_subcat"/>-->
            <xsl:apply-templates select="document(concat('udata://custom/catalog_menu_lite_cache/?root=',@id))/udata/items/item" mode="catalog_subcat"/>
    	</xsl:otherwise>
    </xsl:choose>
    </td></tr></tbody></table>
    тест
    </xsl:if>
	<!-- / подкатегории -->
	<!-- товары -->
    <!--xsl:if test="@id  = 2300">-->

    <xsl:element name="script">
        <xsl:attribute name="type">text/javascript</xsl:attribute>
        <xsl:comment>
    		var iArr = new Array()
        </xsl:comment>
	</xsl:element>

    <!--<xsl:value-of select="$index" disable-output-escaping="yes" />-->
      <xsl:if test="$index = 0">

      	<ul class="products{$lite_suff}">
         <!--<xsl:apply-templates select="document('usel://all_products2/2300/')/udata" mode="catalog_index"/>-->
         <!--<xsl:apply-templates select="document('udata://custom/catalog_index_products_lite/')/udata" mode="catalog_index"/>-->
         <xsl:apply-templates select="document('udata://custom/catalog_index_products/')/udata" mode="catalog_index"/>
        </ul>
      </xsl:if>
      <xsl:if test="$index != 0">

         <!--<xsl:apply-templates select="document(concat('usel://all_products/', @id))/udata" mode="catalog_all"/>-->
         <!-- <xsl:apply-templates select="document(concat('udata://custom/catalog_sub_products/?subcat=', @id))/udata" mode="catalog_all"/> -->
      <!-- <xsl:apply-templates select="document(concat('udata://custom/catalog_sub_products_cache/?subcat=', @id))/udata" mode="catalog_all"/>
             <xsl:apply-templates select="document(concat('udata://custom/getsidtest/', @id,'/', $pre_lang,'/'))/udata" />
         <xsl:value-of select="document(concat('udata://custom/getsidtest/', @id,'/', $pre_lang,'/'))/udata" disable-output-escaping="yes" />-->

               <xsl:choose>
    	   		<xsl:when test="$super = '1'">
                   	<xsl:value-of select="document(concat('udata://custom/getsidtest/', @id,'/', $pre_lang,'/'))/udata" disable-output-escaping="yes" />
            	</xsl:when>
                <xsl:otherwise>

                  	<xsl:apply-templates select="document(concat('udata://custom/catalog_sub_products_cache/?subcat=', @id))/udata" mode="catalog_all"/>
                </xsl:otherwise>
            </xsl:choose>
      </xsl:if>
    <!--</ul>-->

   <!-- </xsl:if> -->
	<!--<ul class="products">
    <xsl:apply-templates select="document(concat('udata://catalog/getObjectsList/notemplate/',@id,'/100/'))/udata/lines/item" mode="catalog_objects" />
	</ul>-->
    <!-- товары -->
<!--<script type="text/javascript" src="/js/showFilterForm.js"></script>-->
    <xsl:element name="script">
        <xsl:attribute name="type">text/javascript</xsl:attribute>
        <xsl:comment>
        	$('.add-to-cart').bind("mousedown", function(){var of = $(this).offset();mx  = of.left;my  = of.top;})
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
<!-- / каталог -->

<!-- подразделы каталога -->
<xsl:template match="item" mode="catalog_subcat">
	<xsl:if test="parent::items/@root != '2300'">
        <xsl:variable name="tmp" select="@alt_name" />
        <xsl:if test="not(document(concat('uobject://', $userIdVar))//property[@name=concat('no_eat_', $tmp)]/value/text() = '1') and not(document(concat('uobject://', $userIdVar))//property[@name=concat('no_eat_all_', $tmp)]/value/text() = '1')" >
            <div style="padding-right: 10px; float:left; text-align:center; height:100px;vertical-align:bottom;">
              <a href="{concat($pre_lang, '/catalog_search/?c_id=',@id,$lite_a)}"><img height="80px" src="{header_pic}" /><br/>
              <!--<xsl:value-of select="@name" disable-output-escaping="yes" />-->
              	<span>
                	<xsl:choose>
                    	<xsl:when test="$pre_lang = '/fr'">
                    	    <xsl:value-of select="@name_fr" disable-output-escaping="yes"  />
                   		</xsl:when>
                    	<xsl:when test="$pre_lang = '/en'">
                        	<xsl:value-of select="@name_eng" disable-output-escaping="yes"  />
                    	</xsl:when>
                    	<xsl:otherwise>
                       	<xsl:value-of select="@name" disable-output-escaping="yes"  />
                    	</xsl:otherwise>
                	</xsl:choose>
                </span>
              </a>
             </div>
        </xsl:if>
    </xsl:if>
</xsl:template>
<!-- подразделы каталога -->
<!--<xsl:key name="products_idx" match="udata/page" use="@club" /> -->

<xsl:template match="udata" mode="catalog_all">
  <table border="0" style="width:100%;"><tbody id="catalogContainer"><tr style="width:100%;"><td style="width:100%;">
	<!--<xsl:if test="total/@club &gt; 0">
      <table border="0" style="width:100%; margin-bottom:20px; margin-top:20px;"><tr style="width:100%"><td style="width:100%; text-align:center;">
      <div align="center" class="zag">
      	<xsl:value-of select="$new_club" />
      </div>
      </td></tr></table>
	</xsl:if>-->

   <xsl:variable name="descr" select="document(concat('upage://', $c_id))//property[@name='descr']/value" disable-output-escaping="yes" />
	  <xsl:if test="$descr != ''">
	  		<!-- Описание категории -->
		  <div class="description"><xsl:value-of select="$descr" disable-output-escaping="yes" /></div>
		  <br/>
  	</xsl:if>
    <ul class="products{$lite_suff}">
    	<xsl:choose>
        	<xsl:when test="$pre_lang = '/fr'">

                <xsl:for-each select="page">
                   <!-- <xsl:sort select="name" order="ascending" data-type="text" lang="ru"/>-->
                    <xsl:sort select="properties/property[@name='shortname_fr']/value" order="ascending" data-type="text" lang="ru"/>
                    <!--<xsl:if test="@club = 'Да'">-->
                       <xsl:variable name="tmp" select="@parent_alt"  />
                       <xsl:if test="not(document(concat('uobject://', $userIdVar))//property[@name=concat('no_eat_', $tmp)]/value/text() = '1')" >
                            <xsl:apply-templates select="." mode="product_block_props"/>
                       </xsl:if>
                    <!--</xsl:if>-->
                </xsl:for-each>

            </xsl:when>
            <xsl:when test="$pre_lang = '/en'">

                <xsl:for-each select="page">
                   <!-- <xsl:sort select="name" order="ascending" data-type="text" lang="ru"/>-->
                    <xsl:sort select="properties/property[@name='shortname_en']/value" order="ascending" data-type="text" lang="ru"/>
                    <!--<xsl:if test="@club = 'Да'">-->
                       <xsl:variable name="tmp" select="@parent_alt"  />
                       <xsl:if test="not(document(concat('uobject://', $userIdVar))//property[@name=concat('no_eat_', $tmp)]/value/text() = '1')" >
                            <xsl:apply-templates select="." mode="product_block_props"/>
                       </xsl:if>
                    <!--</xsl:if>-->
                </xsl:for-each>

            </xsl:when>
            <xsl:otherwise>

                <xsl:for-each select="page">
                   <!-- <xsl:sort select="name" order="ascending" data-type="text" lang="ru"/>-->
                    <xsl:sort select="properties/property[@name='shortname']/value" order="ascending" data-type="text" lang="ru"/>
                    <!--<xsl:if test="@club = 'Да'">-->
                       <xsl:variable name="tmp" select="@parent_alt"  />
                       <xsl:if test="not(document(concat('uobject://', $userIdVar))//property[@name=concat('no_eat_', $tmp)]/value/text() = '1')" >
                            <xsl:apply-templates select="." mode="product_block_props"/>
                       </xsl:if>
                    <!--</xsl:if>-->
                </xsl:for-each>

             </xsl:otherwise>
        </xsl:choose>

        <!--<xsl:apply-templates select="key('products_idx', 'Да')" mode="product_block_props">
        	<xsl:sort select="name" order="ascending" data-type="text" lang="ru"/>
        </xsl:apply-templates>-->
    </ul>
   <!--
    <xsl:if test="(total/@club &gt; 0) and (total/@not_club &gt; 0)">
    	<div style="margin-bottom:20px;" align="center"><img width="95%" height="1px" src="/i/bg/divide_line.gif"/></div>
    </xsl:if>

    <xsl:if test="total/@not_club &gt; 0">
        <table border="0" style="width:100%; margin-bottom:20px; margin-top:10px;"><tr style="width:100%"><td style="width:100%; text-align:center;">
          <div align="center" class="zag">
            <xsl:value-of select="$new_notclub" />
          </div>
        </td></tr></table>
    </xsl:if>

    <ul class="products{$lite_suff}">
        <xsl:choose>
        	<xsl:when test="$pre_lang = '/fr'">

                <xsl:for-each select="page">
                    <xsl:sort select="properties/property[@name='shortname_fr']/value" order="ascending" data-type="text" lang="ru"/>
                    <xsl:if test="@club = 'Нет'">
                       <xsl:variable name="tmp" select="@parent_alt"  />
                       <xsl:if test="not(document(concat('uobject://', $userIdVar))//property[@name=concat('no_eat_', $tmp)]/value/text() = '1')" >
                            <xsl:apply-templates select="." mode="product_block_props"/>
                       </xsl:if>
                    </xsl:if>
                </xsl:for-each>

            </xsl:when>
            <xsl:when test="$pre_lang = '/en'">

                <xsl:for-each select="page">
                    <xsl:sort select="properties/property[@name='shortname_en']/value" order="ascending" data-type="text" lang="ru"/>
                    <xsl:if test="@club = 'Нет'">
                       <xsl:variable name="tmp" select="@parent_alt"  />
                       <xsl:if test="not(document(concat('uobject://', $userIdVar))//property[@name=concat('no_eat_', $tmp)]/value/text() = '1')" >
                            <xsl:apply-templates select="." mode="product_block_props"/>
                       </xsl:if>
                    </xsl:if>
                </xsl:for-each>

            </xsl:when>
            <xsl:otherwise>

                <xsl:for-each select="page">
                    <xsl:sort select="properties/property[@name='shortname']/value" order="ascending" data-type="text" lang="ru"/>
                    <xsl:if test="@club = 'Нет'">
                       <xsl:variable name="tmp" select="@parent_alt"  />
                       <xsl:if test="not(document(concat('uobject://', $userIdVar))//property[@name=concat('no_eat_', $tmp)]/value/text() = '1')" >
                            <xsl:apply-templates select="." mode="product_block_props"/>
                       </xsl:if>
                    </xsl:if>
                </xsl:for-each>

             </xsl:otherwise>
        </xsl:choose>
    </ul>-->
 </td></tr></tbody></table><br/>
  <xsl:variable name="fishki" select="document(concat('upage://', $c_id))//property[@name='fishki']/value" disable-output-escaping="yes" />
     <xsl:if test="$fishki != ''">
	  		<!-- Описание категории -->
		  <div class="description fishki_footer"><xsl:value-of select="$fishki" disable-output-escaping="yes" /></div>
		  <br/>
  	</xsl:if>
</xsl:template>

<!-- заглушки для "странных" цифИрок в каталоге -->
<xsl:template match="total" mode="catalog_all">
</xsl:template>
<xsl:template match="total" mode="catalog_index">
</xsl:template>
<!-- / заглушки для "странных" цифИрок в каталоге -->

<xsl:template match="page" mode="product_block">
	<xsl:apply-templates select="document(concat('upage://', @id))//page" mode="product_block_props" />
</xsl:template>

<!-- О чудо, наконец-то единый блок инфы о товаре -->
<xsl:template match="page" mode="product_block_props">
	<xsl:if test="$lite = ''">
      <xsl:choose>
    	   		<xsl:when test="properties/property[@name='photo_small']/value != ''">
                    <xsl:element name="script">
                    <xsl:attribute name="type">text/javascript</xsl:attribute>
                    <xsl:comment>
                        iArr[iArr.length] = new Array('p_<xsl:value-of select="@id" />', '<xsl:value-of select="properties/property[@name='photo_small']/value" />')
                    </xsl:comment>
                	</xsl:element>
            	</xsl:when>
                <xsl:otherwise>
                  <xsl:element name="script">
                    <xsl:attribute name="type">text/javascript</xsl:attribute>
                    <xsl:comment>
                        iArr[iArr.length] = new Array('p_<xsl:value-of select="@id" />', '<xsl:value-of select="properties/property[@name='photo']/value" />')
                    </xsl:comment>
                	</xsl:element>
                </xsl:otherwise>
            </xsl:choose>
    </xsl:if>




<li class="p_c"><!-- src="{properties/property[@name='photo']/value}" //////////    {concat($pre_lang, @link)}-->
	<xsl:variable name="new_prod_units">
        <xsl:choose>
            <xsl:when test="$pre_lang = '/fr'">
                <xsl:choose>
                    <xsl:when test="properties/property[@name='unit']/value = 'шт'">
                        <xsl:value-of select="$new_thing" disable-output-escaping="yes" />
                    </xsl:when>
                    <xsl:when test="properties/property[@name='unit']/value = 'упак'">
                        <xsl:value-of select="$new_pack" disable-output-escaping="yes" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="properties/property[@name='unit']/value" disable-output-escaping="yes" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="$pre_lang = '/en'">
                <xsl:choose>
                    <xsl:when test="properties/property[@name='unit']/value = 'шт'">
                        <xsl:value-of select="$new_thing" disable-output-escaping="yes" />
                    </xsl:when>
                    <xsl:when test="properties/property[@name='unit']/value = 'упак'">
                        <xsl:value-of select="$new_pack" disable-output-escaping="yes" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="properties/property[@name='unit']/value" disable-output-escaping="yes" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="properties/property[@name='unit']/value" disable-output-escaping="yes" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

		<xsl:if test="$lite = ''">
        <a href="{concat($pre_lang, '/catalog_search/?c_id=',@id,$lite_a)}">
        	<img id="p_{@id}" src="" width="120px" height="120px" />
            <!--<xsl:choose>
    	   		<xsl:when test="properties/property[@name='photo_small']/value != ''">
                   <img width="120px" height="120px" src="{//property[@name='photo_small']/value}" />
            	</xsl:when>
                <xsl:otherwise>
                   <img width="120px" height="120px" src="{//property[@name='photo']/value}" />
                </xsl:otherwise>
            </xsl:choose>-->
        </a>
        </xsl:if>
        <span class="header_block">
		<a href="{concat($pre_lang, '/catalog_search/?c_id=',@id,$lite_a)}" class="tov_zag_c">
        	<xsl:choose>
                <xsl:when test="$pre_lang = '/fr'">
                    <xsl:value-of select="properties/property[@name='shortname_fr']/value"  disable-output-escaping="yes"  /><xsl:text> </xsl:text>
             <span class="bio"><xsl:value-of select="properties/property[@name='bio']/value" disable-output-escaping="yes" /></span><xsl:text> </xsl:text>
             <xsl:value-of select="properties/property[@name='fasovka_en']/value" disable-output-escaping="yes" />
                </xsl:when>
                <xsl:when test="$pre_lang = '/en'">
                    <xsl:value-of select="properties/property[@name='shortname_en']/value"  disable-output-escaping="yes"  /><xsl:text> </xsl:text>
             <span class="bio"><xsl:value-of select="properties/property[@name='bio']/value" disable-output-escaping="yes" /></span><xsl:text> </xsl:text>
             <xsl:value-of select="properties/property[@name='fasovka_en']/value" disable-output-escaping="yes" />
                </xsl:when>
                <xsl:otherwise>
                   <xsl:value-of select="properties/property[@name='shortname']/value"  disable-output-escaping="yes"  /><xsl:text> </xsl:text>
             <span class="bio"><xsl:value-of select="properties/property[@name='bio']/value" disable-output-escaping="yes" /></span><xsl:text> </xsl:text>
             <xsl:value-of select="properties/property[@name='fasovka_ru']/value" disable-output-escaping="yes" />
                </xsl:otherwise>
            </xsl:choose>
        </a>

        <xsl:choose>
            <xsl:when test="contains($combinedFavProducts, @id)">
                <a id="fav_{@id}" href="javascript:toggle_favorite('{@id}','{$userIdVar}');" class="favG"></a>
            </xsl:when>
            <xsl:otherwise>
                <a id="fav_{@id}" href="javascript:toggle_favorite('{@id}','{$userIdVar}');" class="fav"></a>
            </xsl:otherwise>
        </xsl:choose>
     	</span>

        <xsl:variable name="hide_field">
        <xsl:if test="$lite != ''">
        display:none;
        </xsl:if>
        </xsl:variable>

            <xsl:choose>
                <xsl:when test="$pre_lang = '/fr'">
                    <span class="p_cat" style="{$hide_field}">
                   		<xsl:if test="(following-sibling::total/@parent_cat_id != '') and (following-sibling::total/@parent_cat_id != '2300')">
                    		<xsl:value-of select="substring-after(properties/property[@name='product_cat_fr']/value, ' ')"  disable-output-escaping="yes" />
                    	</xsl:if>
                    </span>
                </xsl:when>
                <xsl:when test="$pre_lang = '/en'">
                    <span class="p_cat" style="{$hide_field}">
                    	<xsl:if test="(following-sibling::total/@parent_cat_id != '') and (following-sibling::total/@parent_cat_id != '2300')">
                        	<xsl:value-of select="substring-after(properties/property[@name='product_cat_en']/value, ' ')"  disable-output-escaping="yes" />
                        </xsl:if>
                    </span>
                </xsl:when>
                <xsl:otherwise>
                    <span class="p_cat" style="{$hide_field}">
                    	<xsl:if test="(following-sibling::total/@parent_cat_id != '') and (following-sibling::total/@parent_cat_id != '2300')">
                    		<xsl:value-of select="substring-after(properties/property[@name='product_cat_ru']/value, ' ')"  disable-output-escaping="yes" />
                        </xsl:if>
                    </span>
                </xsl:otherwise>
            </xsl:choose>


        <xsl:if test="$lite = ''">

          <xsl:variable name="cn3">
    					<xsl:value-of select="php:function('urlencode', string(properties/property[@name='country']/value))" />
                    </xsl:variable>



                    <p><xsl:value-of select="$new_country" disable-output-escaping="yes" />: <span class="country"><xsl:value-of select="document(concat('udata://custom/getCountry2/?c=', $cn3))" disable-output-escaping="yes" /></span></p>
		<!--<p><xsl:value-of select="$new_country" />: <span class="cn3"><xsl:value-of select="properties/property[@name='country']/value" disable-output-escaping="yes" /></span></p>-->



        			<p><xsl:variable name="testsid">
                    <xsl:value-of select="php:function('urlencode', string(//property[@name='manufacturer']/value))" disable-output-escaping="no"/>
                    </xsl:variable>
          			<xsl:variable name="linksid">
                    <xsl:value-of select="document(concat('udata://custom/manufacturer/?text=', $testsid))"  disable-output-escaping="yes" />
            		</xsl:variable>
                    <xsl:value-of select="$new_manufacturer" disable-output-escaping="yes" />:
                        <xsl:choose>
                                <xsl:when test="$pre_lang = '/fr'">
                                     <xsl:value-of select="properties/property[@name='manufacturer_fr']/value" disable-output-escaping="yes" />
                                </xsl:when>
                                <xsl:when test="$pre_lang = '/en'">
                                     <xsl:value-of select="properties/property[@name='manufacturer_en']/value" disable-output-escaping="yes" />
                                </xsl:when>
                                <xsl:otherwise>
                                     <xsl:value-of select="properties/property[@name='manufacturer']/value" disable-output-escaping="yes" />
                                </xsl:otherwise>
                         </xsl:choose>
                    <!--<xsl:value-of select="properties/property[@name='manufacturer']/value" disable-output-escaping="yes" />-->

                  <!--    <xsl:choose>
                        	<xsl:when test="$linksid != 0">
                            	<a href="{concat($pre_lang, '/manufacturers/', $linksid)}">
                     				<xsl:value-of select="//property[@name='manufacturer']/value" disable-output-escaping="yes" />
                    			 </a>
                            </xsl:when>
                            <xsl:otherwise>
                            	<xsl:value-of select="//property[@name='manufacturer']/value" disable-output-escaping="yes" />
                            </xsl:otherwise>
                        </xsl:choose> -->

        </p>
        </xsl:if>

        <p style="{$hide_field}"><xsl:value-of select="$new_datep" />: <!--<span class="datep"><xsl:value-of select="properties/property[@name='datep']/value" disable-output-escaping="yes"/></span> --> <span class="nal">
        		<xsl:choose>
                	<xsl:when test="properties/property[@name='datep']/value = 1">
                    	<xsl:value-of select="$new_nal" />
                    </xsl:when>
                    <xsl:otherwise>
                    	<xsl:value-of select="$new_not_nal" />
                    </xsl:otherwise>
                </xsl:choose>
        	</span>
        </p>
		 <!-- Блок ком. к продукту -->
        <xsl:variable name="is_manager" select="document('udata://emarket/is_manager_login/')//is_manager" />
         <xsl:if test="$is_manager = '1'">

         <br/><textarea maxlength="55"  id="comments_products_{@id}" name="comments_products_{@id}" >
         <!-- <xsl:value-of select="document(concat('upage://', @id))//group[@name='product_properties']/property[@name='comment_exp']/value" disable-output-escaping="yes" />-->
         <xsl:value-of select="properties/property[@name='comment_exp']/value" disable-output-escaping="yes" />
         </textarea><br/>
	    	<xsl:element name="script">
	        <xsl:attribute name="type">text/javascript</xsl:attribute>
	        <xsl:comment>

					$('#comments_products_<xsl:value-of select="@id" />').focusout(function() {
						var msg = $('#comments_products_<xsl:value-of select="@id" />').val();
						if (confirm("Вы уверены, что хотите обновить комментарий на "+msg)) {
						 		$.post('/udata/custom/setPropObj/', {id: '<xsl:value-of select="@id" />', msg: msg}, function(data){
				 				alert("Комментарий успешно обнавлен!");
                    		});
						}

					});
		        </xsl:comment>
	    </xsl:element>
      </xsl:if>
        <!-- /Блок ком. к продукту. -->
        <ul class="set-mass">
            <xsl:choose>
            	<xsl:when test="properties/property[@name='stv']/value = 1">
                     <!-- Работа если штучно весовой -->
                     <!-- Получаем вес одной штуки-->
                     <xsl:variable name="ves_one" select="properties/property[@name='weight_stuka']/value * 1000" disable-output-escaping="yes" />
                     <li class="add" title="Уменьшить кол-во"><a href="javascript:sfa_amount2({@id}, false, {$ves_one}, '', '{$new_thing}', '{$new_gr}');">-</a></li>
					 <!--<li class="mass" id="amount_user_{@id}">200гр.</li>-->
                     <li class="mass" id="amount_user_{@id}">
                         <xsl:value-of select="$ves_one" disable-output-escaping="yes" /><xsl:text> </xsl:text><xsl:value-of select="$new_gr" disable-output-escaping="yes" /><br></br>1<xsl:text> </xsl:text><xsl:value-of select="$new_thing" disable-output-escaping="yes" />
                    </li>
			        <li class="deduct" title="Увеличить кол-во"><a href="javascript:sfa_amount2({@id}, true, {$ves_one}, '', '{$new_thing}', '{$new_gr}');">+</a></li>
                              <input type="hidden" name="amount" value="{$ves_one}" id="amount_{@id}" />

                </xsl:when>
                <xsl:otherwise>
                	 <!-- Работа если не штучно весовой -->
                     <xsl:variable name="min_w" >
                         <xsl:choose>
                            <xsl:when test="count(properties/property[@name='min_weight']) &gt; 0">
                            	<xsl:choose>
                                	<xsl:when test="(properties/property[@name='min_weight']/value != 0) and (properties/property[@name='min_weight']/value != '')" >
                                    	<xsl:value-of select="properties/property[@name='min_weight']/value * 1000" />
                                    </xsl:when>
                                    <xsl:otherwise>1000</xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>1000</xsl:otherwise>
                         </xsl:choose>
                     </xsl:variable>

                     <xsl:variable name="min_w_param">
                        <xsl:choose>
                            <xsl:when test="count(properties/property[@name='min_weight']) &gt; 0">
                                <xsl:choose>
                                	<xsl:when test="properties/property[@name='min_weight']/value &gt; 0">
                                    	<xsl:value-of select="$min_w" />
                                    </xsl:when>
                                    <xsl:otherwise>false</xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>false</xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>

           			 <li class="add"  title="Уменьшить кол-во"><a href="javascript:sfa_amount({@id}, false, '{properties/property[@name='unit']/value}', '{$new_prod_units}', '{$new_gr}', {$min_w_param});">-</a></li>
					 <!--<li class="mass" id="amount_user_{@id}">200гр.</li>-->

                     <li class="mass" id="amount_user_{@id}">
                        <xsl:choose>
                            <xsl:when test="properties/property[@name='unit']/value/text() = 'кг'">
                               <!--1000--><xsl:value-of select="$min_w" disable-output-escaping="yes" /><xsl:text> </xsl:text><xsl:value-of select="$new_gr" disable-output-escaping="yes" />
                            </xsl:when>
                            <xsl:otherwise>
                                1<xsl:text> </xsl:text><!--<xsl:value-of select="properties/property[@name='unit']/value" disable-output-escaping="yes" />-->
                                <xsl:value-of select="$new_prod_units" />
                            </xsl:otherwise>
                        </xsl:choose>
           			</li>

			        <li class="deduct" title="Увеличить кол-во"><a href="javascript:sfa_amount({@id}, true, '{properties/property[@name='unit']/value}', '{$new_prod_units}', '{$new_gr}', {$min_w_param});">+</a></li>
                        <xsl:choose>
                        <xsl:when test="properties/property[@name='unit']/value = 'кг'">
                              <input type="hidden" name="amount" value="{$min_w}" id="amount_{@id}" />
                        </xsl:when>
                        <xsl:otherwise>
                              <input type="hidden" name="amount" value="1" id="amount_{@id}" />
                        </xsl:otherwise>
                        </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>

		</ul>

		 <p class="price">
         <!-- получение инфы -->
         <xsl:variable name="cena" select="properties/property[@name='price']/value" disable-output-escaping="yes" />

    <!-- <xsl:value-of select="$units" disable-output-escaping="yes" /> -->
      <xsl:choose>
        <xsl:when test="properties/property[@name='unit']/value = 'кг'">
            <xsl:choose>
                <xsl:when test="contains($ProductCatrgoryPo100gramm, concat(',',@parent_alt,','))">
                    <xsl:value-of select="$cena * 100" disable-output-escaping="yes" /><xsl:text> </xsl:text><xsl:value-of select="$new_rub" disable-output-escaping="yes" />/100<xsl:value-of select="$new_gr" disable-output-escaping="yes" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$cena * 1000" disable-output-escaping="yes" /><xsl:text> </xsl:text><xsl:value-of select="$new_rub" disable-output-escaping="yes" />/<xsl:value-of select="$new_kg" disable-output-escaping="yes" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
         	  <xsl:value-of select="$cena" disable-output-escaping="yes" /><xsl:text> </xsl:text><xsl:value-of select="$new_rub" disable-output-escaping="yes" />/<!--<xsl:value-of select="properties/property[@name='unit']/value" disable-output-escaping="yes" />-->
              <xsl:value-of select="$new_prod_units" />
        </xsl:otherwise>
      </xsl:choose>
        </p>
       <xsl:if test="$lite = ''">
        <dl>
		</dl>
        </xsl:if>
		<a href="javascript:sfa_cart_add('{@id}', 'amount_{@id}', true);" id="c_{@id}" class="add-to-cart" title="В корзину">Add to cart</a>
       <xsl:if test="$lite = ''">
        	<span class="fishki">
            	<xsl:apply-templates select="properties/property[@name='fishka']/items/item" mode="fishki-list" />
            </span>
        </xsl:if>
		</li>
		<xsl:apply-templates select="properties/property[@name='fishka']/items/item" mode="fishki-list-sid" />
</xsl:template>
<!-- / О чудо, наконец-то единый блок инфы о товаре -->

<xsl:template match="item" mode="fishki-list">
<xsl:variable name="tmp" select="ancestor::page/@id" />
<a href="http://lebongout.ru/glossarij_uslovnyh_oboznachenij/"><img id="tooltip_{$tmp}_{@id}" src="{picture/value}" /></a>
</xsl:template>

<xsl:template match="item" mode="fishki-list-sid">
<xsl:variable name="tmp" select="ancestor::page/@id" />
 <xsl:element name="script">
	<xsl:attribute name="type">text/javascript</xsl:attribute>
	<xsl:comment>
$(document).ready(function(){
$("#tooltip_"+"<xsl:value-of select="concat($tmp, '_', @id)" />").tooltip({
    bodyHandler: function() {
        return '<xsl:value-of disable-output-escaping="yes" select="tooltip/value" />'
    },
    showURL: false
})
});
	</xsl:comment>
</xsl:element>
</xsl:template>



<!--Вывод  на главной странице каталога -->
<xsl:template match="page" mode="catalog_index">
<xsl:variable name="tmp" select="@parent_alt" />
 <xsl:if test="not(document(concat('uobject://', $userIdVar))//property[@name=concat('no_eat_', $tmp)]/value/text() = '1')" >
		<xsl:apply-templates select="." mode="product_block_props"/>
    </xsl:if>
 </xsl:template>
<!--/Вывод на главной странице каталога -->

<!-- товар -->
<xsl:template match="page" >
<xsl:if test="basetype[@id='6']">
	<xsl:variable name="units" select="//property[@name='unit']/value" disable-output-escaping="yes" />
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
                        <xsl:value-of select="//property[@name='unit']/value" disable-output-escaping="yes" />
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
                        <xsl:value-of select="//property[@name='unit']/value" disable-output-escaping="yes" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="//property[@name='unit']/value" disable-output-escaping="yes" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

			<div class="product">
			<h2>
            <xsl:choose>
                <xsl:when test="$pre_lang = '/fr'">
                    <xsl:value-of select="//property[@name='shortname_fr']/value"  disable-output-escaping="yes"/><xsl:text> </xsl:text><span class="bio"><xsl:value-of select="//property[@name='bio']/value" disable-output-escaping="yes" /></span>
                </xsl:when>
                <xsl:when test="$pre_lang = '/en'">
                    <xsl:value-of select="//property[@name='shortname_en']/value" disable-output-escaping="yes" /><xsl:text> </xsl:text><span class="bio"><xsl:value-of select="//property[@name='bio']/value" disable-output-escaping="yes" /></span>
                </xsl:when>
                <xsl:otherwise>
                   <xsl:value-of select="//property[@name='shortname']/value" disable-output-escaping="yes" /><xsl:text> </xsl:text><span class="bio"><xsl:value-of select="//property[@name='bio']/value" disable-output-escaping="yes" /></span><xsl:text> </xsl:text>
                    <xsl:value-of select="//property[@name='fasovka']/value" disable-output-escaping="yes" />
                </xsl:otherwise>
            </xsl:choose>
                    <xsl:choose>
                       <xsl:when test="contains($combinedFavProducts, @id)">
                            <a id="fav_{@id}" href="javascript:toggle_favorite('{@id}','{$userIdVar}');" class="favG">Add to favorite</a>
                        </xsl:when>
                        <xsl:otherwise>
                            <a id="fav_{@id}" href="javascript:toggle_favorite('{@id}','{$userIdVar}');" class="fav">Add to favorite</a>
                        </xsl:otherwise>
                      </xsl:choose>
                    </h2>
					<div class="product-preview" style="width:306px !important; margin-right:-5px;" >
						<center><img src="{//property[@name='photo']/value}" width="240px" height="240px"/></center>
                        <!-- Остальные фотки
						<ul>
							<li><a href="#"><img src="/i/src/prod-min.jpg"/></a></li>
							<li><a href="#"><img src="/i/src/prod-min.jpg"/></a></li>
							<li><a href="#"><img src="/i/src/prod-min.jpg"/></a></li>
						</ul>-->

                        <div class="product-order">
							<ul class="set-mass">
            <!-- Получение единиц измерения и количества  -->

            <xsl:variable name="weight" select="//property[@name='weight']/value" disable-output-escaping="yes" />

             <!--Получаем значение на штучно весовой товар -->
            <xsl:variable name="stv" select="//property[@name='stv']/value" disable-output-escaping="yes" />

            <xsl:choose>
            	<xsl:when test="$stv = 1">
                     <!-- Работа если штучно весовой -->
                     <!-- Получаем вес одной штуки-->
                     <xsl:variable name="ves_one" select="//property[@name='weight_stuka']/value * 1000" disable-output-escaping="yes" />
                     <li class="add"  title="Уменьшить количество"><a href="javascript:sfa_amount2({@id}, false, {$ves_one}, '', '{$new_thing}', '{$new_gr}');">-</a></li>
					 <!--<li class="mass" id="amount_user_{@id}">200гр.</li>-->
                     <li class="mass" id="amount_user_{@id}">
                         <xsl:value-of select="$ves_one" disable-output-escaping="yes" /> <xsl:value-of select="$new_gr" disable-output-escaping="yes" /><br></br>1 <xsl:value-of select="$new_thing" disable-output-escaping="yes" />
                    </li>
			        <li class="deduct" title="Увеличить количество"><a href="javascript:sfa_amount2({@id}, true, {$ves_one}, '', '{$new_thing}', '{$new_gr}');">+</a></li>
                              <input type="hidden" name="amount" value="{$ves_one}" id="amount_{@id}" />

                </xsl:when>
                <xsl:otherwise>
                	 <!-- Работа если не штучно весовой -->

                     <xsl:variable name="min_w" >
                         <xsl:choose>
                            <xsl:when test="count(//property[@name='min_weight']) &gt; 0">
                            	<xsl:choose>
                                	<xsl:when test="(//property[@name='min_weight']/value != 0) and (//property[@name='min_weight']/value != '')" >
                                    	<xsl:value-of select="//property[@name='min_weight']/value * 1000" />
                                    </xsl:when>
                                    <xsl:otherwise>1000</xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>1000</xsl:otherwise>
                         </xsl:choose>
                     </xsl:variable>

                     <xsl:variable name="min_w_param">
                        <xsl:choose>
                            <xsl:when test="count(//property[@name='min_weight']) &gt; 0">
                            	<xsl:choose>
                                	<xsl:when test="//property[@name='min_weight']/value &gt; 0">
                                    	<xsl:value-of select="$min_w" />
                                    </xsl:when>
                                    <xsl:otherwise>false</xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>false</xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>

           			 <li class="add"  title="Уменьшить количество"><a href="javascript:sfa_amount({@id}, false, '{$units}', '{$new_prod_units}', '{$new_gr}', {$min_w_param});">-</a></li>
					 <!--<li class="mass" id="amount_user_{@id}">200гр.</li>-->
                     <li class="mass" id="amount_user_{@id}">

                        <xsl:choose>
                            <xsl:when test="$units = 'кг'">
                               <xsl:value-of select="$min_w" /><xsl:text> </xsl:text><xsl:value-of select="$new_gr" disable-output-escaping="yes" />
                        </xsl:when>
                        <xsl:otherwise>
                               1 <!--<xsl:value-of select="document(concat('upage://', @id))//property[@name='unit']/value" disable-output-escaping="yes" />-->
                               <xsl:value-of select="$new_prod_units" />
                        </xsl:otherwise>
                        </xsl:choose>
           			</li>
			        <li class="deduct" title="Увеличить количество"><a href="javascript:sfa_amount({@id}, true, '{$units}', '{$new_prod_units}', '{$new_gr}', {$min_w_param});">+</a></li>
                        <xsl:choose>
                        <xsl:when test="$units = 'кг'">
                              <input type="hidden" name="amount" value="{$min_w}" id="amount_{@id}" />
                        </xsl:when>
                        <xsl:otherwise>
                              <input type="hidden" name="amount" value="1" id="amount_{@id}" />
                        </xsl:otherwise>
                        </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>

		</ul>

							<em class="price">

                             <xsl:variable name="cena" select="//property[@name='price']/value" disable-output-escaping="yes" />

                        <!-- <xsl:value-of select="$units" disable-output-escaping="yes" /> -->
                          <xsl:choose>
                                <xsl:when test="$units = 'кг'">
                                    <xsl:choose>
                                        <xsl:when test="contains($ProductCatrgoryPo100gramm, concat(',',document(concat('upage://', @parentId))//page/@alt-name,','))">
                                            <xsl:value-of select="$cena * 100" disable-output-escaping="yes" /><xsl:text> </xsl:text><xsl:value-of select="$new_rub" disable-output-escaping="yes" />/100<xsl:value-of select="$new_gr" disable-output-escaping="yes" />
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="$cena * 1000" disable-output-escaping="yes" /><xsl:text> </xsl:text><xsl:value-of select="$new_rub" disable-output-escaping="yes" />/<xsl:value-of select="$new_kg" disable-output-escaping="yes" />
                                        </xsl:otherwise>
                                    </xsl:choose>

                            </xsl:when>
                            <xsl:otherwise>
                                  <xsl:value-of select="$cena" disable-output-escaping="yes" /><xsl:text> </xsl:text><xsl:value-of select="$new_rub" disable-output-escaping="yes" />/<!--<xsl:value-of select="$units" disable-output-escaping="yes" />--><xsl:value-of select="$new_prod_units" />
                            </xsl:otherwise>
                          </xsl:choose>


                           <!-- <xsl:value-of select="//property[@name='price']/value" disable-output-escaping="yes" /> руб. -->


                            </em>
							<a href="javascript:sfa_cart_add('{@id}', 'amount_{@id}', true);" id="c_{@id}" class="add-to-cart">Add to cart</a>
						</div>

					</div>

					<div class="descriptions" style="margin-left:-1px !important;">
                    <xsl:variable name="cn3">
    					<xsl:value-of select="php:function('urlencode', string(//property[@name='country']/value))" />
                    </xsl:variable>



                    <p><xsl:value-of select="$new_country" disable-output-escaping="yes" />: <span class="country"><b><xsl:value-of select="document(concat('udata://custom/getCountry2/?c=', $cn3))" disable-output-escaping="yes" /></b></span></p>

                    <xsl:variable name="testsid">
                    <xsl:value-of select="php:function('urlencode', string(//property[@name='manufacturer']/value))" disable-output-escaping="no"/>
                    </xsl:variable>
          			<xsl:variable name="linksid">
                    <xsl:value-of select="document(concat('udata://custom/manufacturer/?text=', $testsid))"  disable-output-escaping="yes" />
            		</xsl:variable>
                    <p><xsl:value-of select="$new_manufacturer" disable-output-escaping="yes" />:
                    <b> <xsl:choose>
                        	<xsl:when test="$linksid != 0">
                            	<a href="{concat($pre_lang, '/manufacturers/', $linksid)}">
                     				<xsl:value-of select="//property[@name='manufacturer']/value" disable-output-escaping="yes" />
                    			 </a>
                            </xsl:when>
                            <xsl:otherwise>
                                     <xsl:choose>
                                            <xsl:when test="$pre_lang = '/fr'">
                                                 <xsl:value-of select="//property[@name='manufacturer_fr']/value" disable-output-escaping="yes" />
                                            </xsl:when>
                                            <xsl:when test="$pre_lang = '/en'">
                                                 <xsl:value-of select="//property[@name='manufacturer_en']/value" disable-output-escaping="yes" />
                                            </xsl:when>
                                            <xsl:otherwise>
                                                 <xsl:value-of select="//property[@name='manufacturer']/value" disable-output-escaping="yes" />
                                            </xsl:otherwise>
                                     </xsl:choose>
                            </xsl:otherwise>
                        </xsl:choose>
                    </b>
                     </p>
                    <p><xsl:value-of select="$new_datep" disable-output-escaping="yes" />: <b>
                    <!--<xsl:variable name="dates" select="//property[@name='datep']/value/@unix-timestamp" disable-output-escaping="yes" />-->



                    <xsl:variable name="dates">
                    	<xsl:choose>
                        	<xsl:when test="count(//property[@name='datep_b']/value) &gt; 0">
                            	<xsl:value-of select="//property[@name='datep_b']/value/@unix-timestamp" />
                            </xsl:when>
                            <xsl:otherwise>
                            	<xsl:value-of select="//property[@name='datep']/value/@unix-timestamp" />
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>

                    <!--<xsl:variable name="$prod_nal">
                    	<xsl:value-of select="document(concat('udata://custom/is_nal/?time=', $dates))" disable-output-escaping="yes" />
                     </xsl:variable>-->
                     <xsl:choose>
                        <xsl:when test="document(concat('udata://custom/is_nal/?time=', $dates)) = 1">
                            <xsl:value-of select="$new_nal" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$new_not_nal" />
                        </xsl:otherwise>
                    </xsl:choose>
                    </b>
       				 <!--<xsl:value-of select="document(concat('udata://system/convertDate/', $dates, '/(d-m)'))" disable-output-escaping="yes"/>-->
        			</p>
                    <p><xsl:value-of select="$new_special" disable-output-escaping="yes" />: <b><xsl:value-of select="document(concat('upage://', @id))//property[@name='quot_fishka_quot_v_nazvanii']/value" disable-output-escaping="yes" /></b></p>
                    <p align="justify">
                    <!--<xsl:value-of select="$new_descr" disable-output-escaping="yes" />: <xsl:value-of select="document(concat('upage://', @id))//property[@name='description']/value" disable-output-escaping="yes" />-->
                    <xsl:choose>
                        <xsl:when test="$pre_lang = '/fr'">
                            <!--<xsl:value-of select="$new_descr" disable-output-escaping="yes" />: --><xsl:value-of select="document(concat('upage://', @id))//property[@name='description_fr']/value" disable-output-escaping="yes" />
                        </xsl:when>
                        <xsl:when test="$pre_lang = '/en'">
                            <!--<xsl:value-of select="$new_descr" disable-output-escaping="yes" />: --><xsl:value-of select="document(concat('upage://', @id))//property[@name='description_en']/value" disable-output-escaping="yes" />
                        </xsl:when>
                        <xsl:otherwise>
                           <!--<xsl:value-of select="$new_descr" disable-output-escaping="yes" />: --><xsl:value-of select="document(concat('upage://', @id))//property[@name='description']/value" disable-output-escaping="yes" />
                        </xsl:otherwise>
                    </xsl:choose>
                    </p>
                    <!-- Доп. Свойства товара -->

					<div>
                    	<xsl:for-each select="document(concat('upage://', @id))//group[@name='product_properties']/property">
								<xsl:if test="value != ''">
										<h3><xsl:value-of select="title" disable-output-escaping="yes" /></h3>
										<p><xsl:value-of select="value" disable-output-escaping="yes" /></p>
								 </xsl:if>
						</xsl:for-each>
					</div>

                    <!-- /Доп. Свойства товара -->
                    <!-- Описание товара, доставки  и прочих параметров
						<p>Рецепты кулинарных блюд, использующих креветок в качестве составляющих, популярны во многих культурах.</p>
						<dl>
							<dt>Доставка:</dt>
							<dd>от 10 дней</dd>
							<dt>Улов:</dt>
							<dd>мелкая сетка</dd>
						</dl>
                        -->

                        <!-- кнопки покупки были тут -->

						<p><!-- Статья о данном продукте --></p>
						<ul class="more-info">
                        <!--  Статьи по теме продукта
							<li><a href="#">Вся статья о мидиях диетолога</a></li>
							<li><a href="#">Рецепт блюда "Мидии в кляре"</a></li>
							<li><a href="#">Диетолог о мидиях</a></li>
                            -->
						</ul>
					</div>
				</div>
                <!-- Сопутствующие товары -->
                <xsl:if test="count(//property[@name='related_products']) &gt; 0">
					<h3 class="title"><xsl:value-of select="$new_we_recomend" disable-output-escaping="yes" />:</h3>
                </xsl:if>
				<ul class="products">
                	<xsl:apply-templates select="//property[@name='related_products']/value" mode="recommended-products-page"/>
					<!-- <li>
						<img src="/i/src/p-im.png" />
						<h2>Филадельфийские мидии <a href="#" class="favorite">Add to favorite</a></h2>
						<p>Рецепты кулинарных блюд, использующих креветок в качестве составляющих, популярны во многих культурах.</p>
						<ul class="set-mass">
							<li class="add"><a href="#">-</a></li>
							<li class="mass">200гр.</li>
							<li class="deduct"><a href="#">+</a></li>
						</ul>
						<p class="price">2500 руб.</p>
						<dl>
							<dt>Доставка:</dt>
							<dd>от 10 дней</dd>
							<dt>Улов:</dt>
							<dd>мелкая сетка</dd>
							<dt>Доставка:</dt>
							<dd>1 ноября</dd>
						</dl>
						<a href="#" class="add-to-cart">Add to cart</a>
					</li>
					<li>
						<img src="/i/src/p-im.png" />
						<h2>Филадельфийские мидии <a href="#" class="favorite">Add to favorite</a></h2>
						<p>Рецепты кулинарных блюд, использующих креветок в качестве составляющих, популярны во многих культурах.</p>
						<ul class="set-mass">
							<li class="add"><a href="#">-</a></li>
							<li class="mass">200гр.</li>
							<li class="deduct"><a href="#">+</a></li>
						</ul>
						<p class="price">2500 руб.</p>
						<dl>
							<dt>Доставка:</dt>
							<dd>от 10 дней</dd>
							<dt>Улов:</dt>
							<dd>мелкая сетка</dd>
							<dt>Доставка:</dt>
							<dd>1 ноября</dd>
						</dl>
						<a href="#" class="add-to-cart">Add to cart</a>
					</li>-->
				</ul>

	<xsl:element name="script">
    	<xsl:attribute name="type">text/javascript</xsl:attribute>
    	<xsl:comment>
    		$('.add-to-cart').mousedown(     function(){var of = $(this).offset();mx  = of.left;my  = of.top;})
    	</xsl:comment>
	</xsl:element>
</xsl:if>
</xsl:template>
<!-- / товар -->

<xsl:template mode="recommended-products-page" match="value">
	<xsl:apply-templates mode="recommended-products" select="document(concat('upage://',text()))//page" />
</xsl:template>

<xsl:template mode="recommended-products" match="page">
	<xsl:variable name="units" select="//property[@name='unit']/value" disable-output-escaping="yes" />
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
                        <xsl:value-of select="//property[@name='unit']/value" disable-output-escaping="yes" />
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
                        <xsl:value-of select="//property[@name='unit']/value" disable-output-escaping="yes" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="//property[@name='unit']/value" disable-output-escaping="yes" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

	<li class="p_c">
    <a href="{concat($pre_lang, '/catalog_search/?c_id=',@id,$lite_a)}">
    		<xsl:choose>
    	   		<xsl:when test="//property[@name='photo_small']/value != ''">
                   <img width="120px" height="120px" src="{//property[@name='photo_small']/value}" />
            	</xsl:when>
                <xsl:otherwise>
                   <img width="120px" height="120px" src="{//property[@name='photo']/value}" />
                </xsl:otherwise>
            </xsl:choose>
    </a>
    <a href="{concat($pre_lang, '/catalog_search/?c_id=',@id,$lite_a)}" class="tov_zag">
    <xsl:choose>
        <xsl:when test="$pre_lang = '/fr'">
            <xsl:value-of select="//property[@name='shortname_fr']/value"  disable-output-escaping="yes"/><xsl:text> </xsl:text><span class="bio"><xsl:value-of select="//property[@name='bio']/value" disable-output-escaping="yes" /></span>
        </xsl:when>
        <xsl:when test="$pre_lang = '/en'">
            <xsl:value-of select="//property[@name='shortname_en']/value" disable-output-escaping="yes" /><xsl:text> </xsl:text><span class="bio"><xsl:value-of select="//property[@name='bio']/value" disable-output-escaping="yes" /></span>
        </xsl:when>
        <xsl:otherwise>
           <xsl:value-of select="//property[@name='shortname']/value" disable-output-escaping="yes" /><xsl:text> </xsl:text><span class="bio"><xsl:value-of select="//property[@name='bio']/value" disable-output-escaping="yes" /></span><xsl:text> </xsl:text>
            <xsl:value-of select="//property[@name='fasovka']/value" disable-output-escaping="yes" />
        </xsl:otherwise>
    </xsl:choose>
    </a>
    <xsl:choose>
       <xsl:when test="contains($combinedFavProducts, @id)">
            <a id="fav_{@id}" href="javascript:toggle_favorite('{@id}','{$userIdVar}');" class="favG">Add to favorite</a>
        </xsl:when>
        <xsl:otherwise>
            <a id="fav_{@id}" href="javascript:toggle_favorite('{@id}','{$userIdVar}');" class="fav">Add to favorite</a>
        </xsl:otherwise>
      </xsl:choose>

    <ul class="set-mass">
        <xsl:choose>
            <xsl:when test="//property[@name='stv']/value = 1">
                 <!-- Работа если штучно весовой -->
                 <!-- Получаем вес одной штуки-->
                 <xsl:variable name="ves_one" select="//property[@name='weight_stuka']/value * 1000" disable-output-escaping="yes" />
                 <li class="add" title="Уменьшить кол-во"><a href="javascript:sfa_amount2({@id}, false, {$ves_one}, '', '{$new_thing}', '{$new_gr}');">-</a></li>
                 <!--<li class="mass" id="amount_user_{@id}">200гр.</li>-->
                 <li class="mass" id="amount_user_{@id}">
                     <xsl:value-of select="$ves_one" disable-output-escaping="yes" /><xsl:text> </xsl:text><xsl:value-of select="$new_gr" disable-output-escaping="yes" /><br></br>1<xsl:text> </xsl:text><xsl:value-of select="$new_thing" disable-output-escaping="yes" />
                </li>
                <li class="deduct" title="Увеличить кол-во"><a href="javascript:sfa_amount2({@id}, true, {$ves_one}, '', '{$new_thing}', '{$new_gr}');">+</a></li>
                          <input type="hidden" name="amount" value="{$ves_one}" id="amount_{@id}" />

            </xsl:when>
            <xsl:otherwise>
                 <!-- Работа если не штучно весовой -->

                 <xsl:variable name="min_w" >
                         <xsl:choose>
                            <xsl:when test="count(//property[@name='min_weight']) &gt; 0">
                            	<xsl:choose>
                                	<xsl:when test="(//property[@name='min_weight']/value != 0) and (//property[@name='min_weight']/value != '')" >
                                    	<xsl:value-of select="//property[@name='min_weight']/value * 1000" />
                                    </xsl:when>
                                    <xsl:otherwise>1000</xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>1000</xsl:otherwise>
                         </xsl:choose>
                     </xsl:variable>

                     <xsl:variable name="min_w_param">
                        <xsl:choose>
                            <xsl:when test="count(//property[@name='min_weight']) &gt; 0">
                            	<xsl:choose>
                                	<xsl:when test="//property[@name='min_weight']/value &gt; 0">
                                    	<xsl:value-of select="$min_w" />
                                    </xsl:when>
                                    <xsl:otherwise>false</xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>false</xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>

                 <li class="add" title="Уменьшить кол-во"><a href="javascript:sfa_amount({@id}, false, '{//property[@name='unit']/value}', '{$new_prod_units}', '{$new_gr}', {$min_w_param});">-</a></li>
                 <!--<li class="mass" id="amount_user_{@id}">200гр.</li>-->
                 <li class="mass" id="amount_user_{@id}">

                    <xsl:choose>
                        <xsl:when test="//property[@name='unit']/value/text() = 'кг'">
                           <xsl:value-of select="$min_w" disable-output-escaping="yes" /><xsl:text> </xsl:text><xsl:value-of select="$new_gr" disable-output-escaping="yes" />
                        </xsl:when>
                        <xsl:otherwise>
                            1<xsl:text> </xsl:text><!--<xsl:value-of select="properties/property[@name='unit']/value" disable-output-escaping="yes" />-->
                            <xsl:value-of select="$new_prod_units" />
                        </xsl:otherwise>
                    </xsl:choose>
                </li>
                <li class="deduct" title="Увеличить кол-во"><a href="javascript:sfa_amount({@id}, true, '{//property[@name='unit']/value}', '{$new_prod_units}', '{$new_gr}', {$min_w_param});">+</a></li>
                    <xsl:choose>
                    <xsl:when test="//property[@name='unit']/value = 'кг'">
                          <input type="hidden" name="amount" value="{$min_w}" id="amount_{@id}" />
                    </xsl:when>
                    <xsl:otherwise>
                          <input type="hidden" name="amount" value="1" id="amount_{@id}" />
                    </xsl:otherwise>
                    </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>

    </ul>

    <em class="price">
     <xsl:variable name="cena" select="//property[@name='price']/value" disable-output-escaping="yes" />

    <!-- <xsl:value-of select="$units" disable-output-escaping="yes" /> -->
      <xsl:choose>
            <xsl:when test="$units = 'кг'">
                <xsl:choose>
                    <xsl:when test="contains($ProductCatrgoryPo100gramm, concat(',',document(concat('upage://', @parentId))//page/@alt-name,','))">
                        <xsl:value-of select="$cena * 100" disable-output-escaping="yes" /><xsl:text> </xsl:text><xsl:value-of select="$new_rub" disable-output-escaping="yes" />/100<xsl:value-of select="$new_gr" disable-output-escaping="yes" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$cena * 1000" disable-output-escaping="yes" /><xsl:text> </xsl:text><xsl:value-of select="$new_rub" disable-output-escaping="yes" />/<xsl:value-of select="$new_kg" disable-output-escaping="yes" />
                    </xsl:otherwise>
                </xsl:choose>

        </xsl:when>
        <xsl:otherwise>
              <xsl:value-of select="$cena" disable-output-escaping="yes" /><xsl:text> </xsl:text><xsl:value-of select="$new_rub" disable-output-escaping="yes" />/<!--<xsl:value-of select="$units" disable-output-escaping="yes" />--><xsl:value-of select="$new_prod_units" />
        </xsl:otherwise>
      </xsl:choose>


    </em>
    <dl>
	</dl>
   <a href="javascript:sfa_cart_add('{@id}', 'amount_{@id}', true);" id="c_{@id}" class="add-to-cart">Add to cart</a>

    </li>
</xsl:template>

</xsl:stylesheet>