const injectScript = require('injectScript');
const copyFromWindow = require('copyFromWindow');
const setInWindow = require('setInWindow');
const callLater = require('callLater');
const makeTableMap = require('makeTableMap');
const log = require('logToConsole');

log('GTM AT Internet Tag Template - Data =', data);


 

// Tracker Configurations Keys
const trackConfKeys = ["site", "log", "logSSL", "domain", "collectDomain", "collectDomainSSL", "userIdOrigin", "secure", "pixelPath", "disableCookie", "disableStorage", "cookieSecure", "cookieDomain", "preview", "plgs", "lazyLoadingPath", "documentLevel", "redirect", "activateCallbacks", "medium", "ignoreEmptyChapterValue", "base64Storage", "sendHitWhenOptOut", "visitLifetime", "redirectionLifetime", "Campaigns", "Storage", "TechClicks", "ClientSideUserId", "ContextVariables", "InternalSearch", "Ecommerce", "Event", "IdentifiedVisitor"];

// Track Type
const trackType = data.trackType;

// AT Internet Settings variable
const atInternetSettings = data.atInternetSettings;

// Smarttag Url
const smarttagURL = atInternetSettings.scriptURL;

// Tracker Settings variables
const settingsTrackerConfiguration = atInternetSettings.trackerConfiguration;
const tagTrackerConfiguration = makeTableMap(data.trackerConfiguration || [{}], 'key', 'value');
const settingsTrackerContext = atInternetSettings.trackerContext;
const tagTrackerContext = makeTableMap(data.trackerContext || [{}], 'key', 'value');

// Props variables
const settingsProperties = atInternetSettings.props;
const trackerProperties = makeTableMap(data.trackerProperties || [{}], 'key', 'value');


// Page Settings variables
const pageName = data.pageName || atInternetSettings.page.name;
const pageChapter1 = data.pageChapter1 || atInternetSettings.page.chapter1;
const pageChapter2 = data.pageChapter2 || atInternetSettings.page.chapter2;
const pageChapter3 = data.pageChapter3 || atInternetSettings.page.chapter3;
const pageLevel2 = data.pageLevel2 || atInternetSettings.page.level2;
const pageCustomObject = data.pageCustomObject || atInternetSettings.page.customObject;

// Identified Visitors variables
const visitorId = data.visitorId || atInternetSettings.identifiedVisitors.visitorId;
const visitorCategory = data.visitorCategory || atInternetSettings.identifiedVisitors.visitorCategory;

// Pages and Site Indicatores variables
const settingsPageIndicators = atInternetSettings.pageIndicators;
const tagPageIndicators = makeTableMap(data.pageIndicatorsTable || [{}], 'key', 'value');
const settingsSiteIndicators = atInternetSettings.siteIndicators;
const tagSiteIndicators = makeTableMap(data.siteIndicatorsTable|| [{}], 'key', 'value');

// Search Results variables
const keyword = data.keyword || atInternetSettings.internalSearch.keyword;
const resultPageNumber = data.resultPageNumber || atInternetSettings.internalSearch.resultPageNumber;
const resultPosition = data.resultPosition || atInternetSettings.internalSearch.resultPosition;

// MV Testing variables
const test = data.test || atInternetSettings.mvTesting.test;
const waveId = data.waveId || atInternetSettings.mvTesting.waveId;
const creation = data.creation || atInternetSettings.mvTesting.creation ;
const experiences = data.experiences || atInternetSettings.mvTesting.experiences;

// Dynamic Labels variables
const dynamicLabelsPageId = data.dynamicLabelsPageId || atInternetSettings.dynamicLabels.pageId;
const dynamicLabelsChapter1 = data.dynamicLabelsChapter1 || atInternetSettings.dynamicLabels.chapter1;
const dynamicLabelsChapter2 = data.dynamicLabelsChapter2 || atInternetSettings.dynamicLabels.chapter2;
const dynamicLabelsChapter3 = data.dynamicLabelsChapter3 || atInternetSettings.dynamicLabels.chapter3;
const dynamicLabelsUpdate = data.dynamicLabelsUpdate || atInternetSettings.dynamicLabels.update;

// Custom Tree Structure variables
const category1 = data.category1 || atInternetSettings.customTreeStructure.category1;
const category2 = data.category2 || atInternetSettings.customTreeStructure.category2;
const category3 = data.category3 || atInternetSettings.customTreeStructure.category3;

// Click Settings variables
const clickName = data.clickName;
const clickChapter1 = data.clickChapter1;
const clickChapter2 = data.clickChapter2;
const clickChapter3 = data.clickChapter3;
const clickLevel2 = data.clickLevel2;
const clickCustomObject = data.clickCustomObject;
const clickType = data.clickType;
const clickElem = data.clickElem;
const clickEvent = data.clickEvent;
const clickCallback = data.clickCallback;

// Event Settings variables
const eventName = data.eventName;
const eventProperties = makeTableMap(data.eventProperties || [{}], 'key', 'value');


// Media (Rich Media) variables
const mediaType = data.mediaType;
const mediaPlayerId = data.mediaPlayerId;
const mediaLevel2 = data.mediaLevel2;
const mediaLabel = data.mediaLabel;
const mediaTheme1 = data.mediaTheme1;
const mediaTheme2 = data.mediaTheme2;
const mediaTheme3 = data.mediaTheme3;
const mediaLinkedContent = data.mediaLinkedContent;
const mediaRefreshDuration = data.mediaRefreshDuration;
const mediaDuration = data.mediaDuration;
const mediaIsEmbedded = data.mediaIsEmbedded;
const mediaBroadcastMode = data.mediaBroadcastMode;
const mediaWebDomain = data.mediaWebDomain;
const mediaAction = data.mediaAction;
const mediaIsBuffering = data.mediaIsBuffering;

// AD variables
const adImpressions = data.adImpressions;

// Sales Insights variables
const cartId = data.cartId;
const products = data.products;
const currency = data.currency;
const turnoverTaxIncluded = data.turnoverTaxIncluded;
const turnoverTaxFree = data.turnoverTaxFree;
const creation_utc = data.creation_utc;
const quantity = data.quantity;
const nbDistinctProduct = data.nbDistinctProduct;
const delivery = data.delivery;
const costTaxIncluded = data.costTaxIncluded;
const costTaxFree = data.costTaxFree;
const paymentMode = data.paymentMode;
const transactionId = data.transactionId;
const transactionStatus = data.transactionStatus;
const promoCode = data.promoCode;
const firstPurchase = data.firstPurchase;

const pixel = {
  // Init Instance
  init: () => {
    const ATInternet = copyFromWindow('ATInternet');
    let ATTags = copyFromWindow('ATTags'); 
    const trackerSettingsContext = setDefinedObject(settingsTrackerContext, tagTrackerContext);
    

    
    if(!ATTags) {
      setInWindow('ATTags', [[smarttagURL],['']], true);
    }
    else if (ATTags[0].indexOf(smarttagURL) == -1) {
      ATTags[0].push(smarttagURL);
      ATTags[1].push(['']);
      setInWindow('ATTags', ATTags, true);
    }

    ATInternet.Tracker.Tag({}, trackerSettingsContext);

    callLater(pixel.tracker);    
  },
  // Set Tracker configuration  
  tracker: () => {
    const ATInternet = copyFromWindow('ATInternet');
    let ATTags = copyFromWindow('ATTags');
    const trackerSettingsConfiguration = setDefinedObject(settingsTrackerConfiguration, tagTrackerConfiguration);       const props = setDefinedObject(settingsProperties, trackerProperties);
    let configurationSettings = {};
    
    if(ATTags[1][ATTags[0].indexOf(smarttagURL)] == '') {
      trackConfKeys.forEach((element) => {
        configurationSettings[element] = ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].getConfig(element);
      });
      ATTags[1][ATTags[0].indexOf(smarttagURL)] = configurationSettings;
    }
    else {
      configurationSettings = ATTags[1][ATTags[0].indexOf(smarttagURL)];
    }
    
    log('ATTags', ATTags);
    setInWindow('ATTags', ATTags, true);
    
    for (var keyConf in configurationSettings) {
      ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].setConfig(keyConf, '');
    }

    configurationSettings = setDefinedObject(configurationSettings, trackerSettingsConfiguration);
        
    for(let key in configurationSettings) {
      ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].setConfig(key, configurationSettings[key]);  
    }
        
    ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].setContext('page', {});
    ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].setProps(props); 
    
    log('GTM AT Internet Template - Tracker Configuration - OK ', configurationSettings);

    switch(trackType){
      case 'page':
      case 'click':
      case 'event':  
      case 'adClickSelfPromotion':
      case 'adClickPublisher':
      case 'displayCart':
      case 'cartAwaitingPayment':
      case 'transactionConfirmation':
        pixel.page();
        break;
      default:
        pixel[trackType]();
    }
  },
  
  
  // Set Page informations
  page: () => {
    const ATInternet = copyFromWindow('ATInternet');
    const pageObj = setDefinedObject({
      'name': pageName,
      'chapter1': pageChapter1,
      'chapter2': pageChapter2,
      'chapter3': pageChapter3,
      'level2': pageLevel2,
      'customObject': pageCustomObject
    });

    if(ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].page && pageObj) {
      ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].page.set(pageObj);      
      log('GTM AT Internet Template - Pages Settings - OK', pageObj); 
    }

    pixel.identifiedVisitor();
  },  
  // Set Identified Visitor
  identifiedVisitor: () => {
    const ATInternet = copyFromWindow('ATInternet'); 
    const identifiedVisitorObj = setDefinedObject({
      'id': visitorId,
      'category': visitorCategory
    });

    if(ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].identifiedVisitor){
      if(identifiedVisitorObj){
        ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].identifiedVisitor.set(identifiedVisitorObj);        
        log('GTM AT Internet Template - Identified Visitor set - OK', identifiedVisitorObj);
      }
      else {
        ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].identifiedVisitor.unset(); 
        log('GTM AT Internet Template - Identified Visitor unset - OK');
      }
    }        
    pixel.customVars();
  },
  // Set Page and Site indicators
  customVars: () => {
    const ATInternet = copyFromWindow('ATInternet');
    const pageIndicators = setDefinedObject(settingsPageIndicators, tagPageIndicators);
    const siteIndicators = setDefinedObject(settingsSiteIndicators, tagSiteIndicators);

    if(ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].customVars) {
      
      ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].customVars.set({
        'page': pageIndicators,
        'site': siteIndicators
      });   
      log('GTM AT Internet Template - Pages Indicators - OK', pageIndicators); 
      log('GTM AT Internet Template - Sites Indicators - OK', siteIndicators);  
    }

    pixel.internalSearch();  
  },
  // Set Internal search
  internalSearch: () => {
    const ATInternet = copyFromWindow('ATInternet');
    const internalSearchObj = setDefinedObject({
      'keyword': keyword,
      'resultPageNumber': resultPageNumber,
      'resultPosition': resultPosition
    });

    if(ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].internalSearch && internalSearchObj) {
      ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].internalSearch.set(internalSearchObj);
      log('GTM AT Internet Template - Internal Search - OK', internalSearchObj);     
    }    

    pixel.mvTesting();
  },
  // Set MV Testing
  mvTesting: () => {
    const ATInternet = copyFromWindow('ATInternet');
    const mvTestingObj = setDefinedObject({
      'test': test,
      'waveId': waveId,
      'creation': creation
    });

    if(ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].mvTesting && mvTestingObj) {    
      ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].mvTesting.set(mvTestingObj);
      log('GTM AT Internet Template - MV Testing - OK', mvTestingObj);

      experiences.forEach(element => ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].mvTesting.add(element));
      log('GTM AT Internet Template - MV Testing - OK', experiences);
    }    

    pixel.dynamicsLabel();
  },
  // Set Dynamic Label
  dynamicsLabel: () => {
    const ATInternet = copyFromWindow('ATInternet');
    const dynamicsLabelObj = setDefinedObject({
      'pageId': dynamicLabelsPageId,
      'chapter1': dynamicLabelsChapter1,
      'chapter2': dynamicLabelsChapter2,
      'chapter3': dynamicLabelsChapter3,
      'update': dynamicLabelsUpdate
    });

    if(ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].dynamicLabel && dynamicsLabelObj){
      ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].dynamicLabel.set(dynamicsLabelObj);
      log('GTM AT Internet Template - Dynamics Label - OK', dynamicsLabelObj);
    }     

    pixel.customTreeStructure(); 
  },
  // Set Custom Tree Structure
  customTreeStructure: () => {
    const ATInternet = copyFromWindow('ATInternet');
    const customTreeStructureObj = setDefinedObject({
      'category1': category1,
      'category2': category2,
      'category3': category3
    });

    if(ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].customTreeStructure && customTreeStructureObj){
      ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].customTreeStructure.set(customTreeStructureObj);  
      log('GTM AT Internet Template - Custom Tree Structure - OK', customTreeStructureObj);    
    }   
    
    if(trackType == 'page') {
      pixel.dispatch(); 
    } 
    else {
      pixel[trackType]();
    }
  },
  // Set Event informations
  event: () => {
    const ATInternet = copyFromWindow('ATInternet');
   
    if(ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].event){
      ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].events.send(eventName, eventProperties);
      log('GTM AT Internet Template - Event - OK'); 
    }
  },   
  // Set Click informations
  click: () => {
    const ATInternet = copyFromWindow('ATInternet');
    const clickObj = setDefinedObject({
        'elem': clickElem,
        'name': clickName, 
        'chapter1': clickChapter1, 
        'chapter2': clickChapter2, 
        'chapter3': clickChapter3, 
        'level2': clickLevel2, 
        'type': clickType, 
        'customObject': clickCustomObject,
        'event': clickEvent,
        'clickCallback': clickCallback
      });

    if(ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].click && clickObj){
      ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].click.send(clickObj);
      log('GTM AT Internet Template - Click - OK', clickObj); 
    }
  },   
  // Set Media (Rich Media)
  richMedia: () => {
    const ATInternet = copyFromWindow('ATInternet');
    const mediaAdd = setDefinedObject({
      'mediaType': mediaType,
      'playerId': mediaPlayerId,
      'mediaLevel2': mediaLevel2,
      'mediaLabel': mediaLabel,
      'mediaTheme1': mediaTheme1,
      'mediaTheme2': mediaTheme2,
      'mediaTheme3': mediaTheme3,
      'linkedContent': mediaLinkedContent,
      'refreshDuration': mediaRefreshDuration,
      'duration': mediaDuration,
      'isEmbedded': mediaIsEmbedded,
      'broadcastMode': mediaBroadcastMode,
      'webdomain': mediaWebDomain
    });
    const mediaSend = setDefinedObject({
      'action': mediaAction,
      'playerId': mediaPlayerId,
      'mediaLabel': mediaLabel,
      'mediaTheme1': mediaTheme1,
      'mediaTheme2': mediaTheme2,
      'mediaTheme3': mediaTheme3,
      'isBuffering': mediaIsBuffering
    });

    if(ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].richMedia){
      if(mediaAdd){
        ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].richMedia.add(mediaAdd);
        log('GTM AT Internet Template - Media (Rich Media) Add - OK', mediaAdd);  
      }
      if(mediaSend){
        ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].richMedia.send(mediaSend);
        log('GTM AT Internet Template - Media (Rich Media) Send - OK', mediaSend);
      }  
    }
  },
  // Set AD Impression (Self Promotion)
  adImpressionSelfPromotion: () => {
    const ATInternet = copyFromWindow('ATInternet');
    
    if(ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].selfPromotion && adImpressions.length > 0){
      adImpressions.forEach(element => ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].selfPromotion.add({
        'impression': element
      }));
      log('GTM AT Internet Template - AD Impression (Self Promotion) - Impressions - OK', adImpressions);
    }
    
    pixel.dispatch(); 
  },
  // Set AD Impression (Publisher)
  adImpressionPublisher: () => {
    const ATInternet = copyFromWindow('ATInternet');
    
    if(ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].publisher && adImpressions.length > 0){
      adImpressions.forEach(element => ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].publisher.add({
        'impression': element
      }));
      log('GTM AT Internet Template - AD Impression (Publisher) - Impressions - OK', adImpressions);
    }
    
    pixel.dispatch(); 
  },
  // Set AD Click (Self Promotion)
  adClickSelfPromotion: () => {
    const ATInternet = copyFromWindow('ATInternet');
    
    if(ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].selfPromotion && adImpressions.length > 0){
      adImpressions.forEach(element => ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].selfPromotion.send({
        'click': element
      }));
      log('GTM AT Internet Template - AD Click (Self Promotion) - Impressions - OK', adImpressions);
    }
  },
  // Set AD Click (Publisher)
  adClickPublisher: () => {
    const ATInternet = copyFromWindow('ATInternet');
    
    if(ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].publisher && adImpressions.length > 0){
      adImpressions.forEach(element => ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].publisher.send({
        'click': element
      }));
      log('GTM AT Internet Template - AD Click (Publisher) - Impressions - OK', adImpressions);
    }
  },
  // Set Display Product (Sales Insights)
  displayProduct: () => {
    const ATInternet = copyFromWindow('ATInternet');
    
    if(ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].ecommerce && products.length > 0){
      ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].ecommerce.displayProduct.products.set(products);
      log('GTM AT Internet Template - Display Product (Sales Insights) - Products - OK', products);
    }

    pixel.dispatch(); 
  },
  // Set Display Page Product (Sales Insights)
  displayPageProduct: () => {
    const ATInternet = copyFromWindow('ATInternet');
    
    if(ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].ecommerce && products.length > 0){
      ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].ecommerce.displayPageProduct.products.set(products);
      log('GTM AT Internet Template - Display Page Product (Sales Insights) - Products - OK', products);
    }

    pixel.dispatch(); 
  },
  // Set Add Product (Sales Insights)
  addProduct: () => {
    const ATInternet = copyFromWindow('ATInternet');
    
    if(ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].ecommerce){
      if(cartId) {
        ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].ecommerce.addProduct.cart.set({
          'id': cartId
        });
        log('GTM AT Internet Template - Add Product (Sales Insights) - Cart - OK', cartId);
      }
      if(products.length > 0) {
        ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].ecommerce.addProduct.products.set(products);
        log('GTM AT Internet Template - Add Product (Sales Insights) - Products - OK', products);
      }      
    }

    pixel.dispatch(); 
  },
  // Set Remove Product (Sales Insights)
  removeProduct: () => {
    const ATInternet = copyFromWindow('ATInternet');
    
    if(ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].ecommerce){
      if(cartId) {
        ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].ecommerce.removeProduct.cart.set({
          'id': cartId
        });
        log('GTM AT Internet Template - Remove Product (Sales Insights) - Cart - OK', cartId);
      }
      if(products.length > 0) {
        ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].ecommerce.removeProduct.products.set(products);
        log('GTM AT Internet Template - Remove Product (Sales Insights) - Products - OK', products);
      }
    }

    pixel.dispatch(); 
  },
  // Set Display Cart (Sales Insights)
  displayCart: () => {
    const ATInternet = copyFromWindow('ATInternet');
    const cartObj = setDefinedObject({
      'id': cartId,
      'currency': currency,
      'turnovertaxincluded': turnoverTaxIncluded,
      'turnovertaxfree': turnoverTaxFree,
      'quantity': quantity,
      'nbdistinctproduct': nbDistinctProduct
    });
    
    if(ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].ecommerce && cartObj){
      ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].ecommerce.displayCart.cart.set(cartObj);
      log('GTM AT Internet Template - Display Cart (Sales Insights) - Cart - OK', cartObj);
    }

    pixel.dispatch(); 
  },
  // Set Update Cart (Sales Insights)
  updateCart: () => {
    const ATInternet = copyFromWindow('ATInternet');
    const cartObj = setDefinedObject({
      'id': cartId,
      'currency': currency,
      'turnovertaxincluded': turnoverTaxIncluded,
      'turnovertaxfree': turnoverTaxFree,
      'quantity': quantity,
      'nbdistinctproduct': nbDistinctProduct
    });
    
    if(ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].ecommerce && cartObj){
      ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].ecommerce.updateCart.cart.set(cartObj);
      log('GTM AT Internet Template - Update Cart (Sales Insights) - Cart - OK', cartObj);
    }

    pixel.dispatch(); 
  },
  // Set Delivery Checkout (Sales Insights)
  deliveryCheckout: () => {
    const ATInternet = copyFromWindow('ATInternet');
    const cartObj = setDefinedObject({
      'id': cartId,
      'currency': currency,
      'turnovertaxincluded': turnoverTaxIncluded,
      'turnovertaxfree': turnoverTaxFree,
      'quantity': quantity,
      'nbdistinctproduct': nbDistinctProduct
    });
    const shippingObj = setDefinedObject({
      'delivery': delivery,
      'costtaxincluded': costTaxIncluded,
      'costtaxfree': costTaxFree
    });
    
    if(ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].ecommerce){
      if(cartObj) {
        ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].ecommerce.deliveryCheckout.cart.set(cartObj);
        log('GTM AT Internet Template - Delivery Checkout (Sales Insights) - Cart - OK', cartObj);
      }
      if(shippingObj) {
        ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].ecommerce.deliveryCheckout.shipping.set(shippingObj);
        log('GTM AT Internet Template - Delivery Checkout (Sales Insights) - Shipping - OK', shippingObj);
      }
    }    

    pixel.dispatch(); 
  },
  // Set Payment Checkout (Sales Insights)
  paymentCheckout: () => {
    const ATInternet = copyFromWindow('ATInternet');
    const cartObj = setDefinedObject({
      'id': cartId,
      'currency': currency,
      'turnovertaxincluded': turnoverTaxIncluded,
      'turnovertaxfree': turnoverTaxFree,
      'quantity': quantity,
      'nbdistinctproduct': nbDistinctProduct
    });
    const shippingObj = setDefinedObject({
      'delivery': delivery,
      'costtaxincluded': costTaxIncluded,
      'costtaxfree': costTaxFree
    });
    
    if(ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].ecommerce){
      if(cartObj) {
        ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].ecommerce.paymentCheckout.cart.set(cartObj);
        log('GTM AT Internet Template - Payment Checkout (Sales Insights) - Cart - OK', cartObj);
      }
      if(shippingObj) {
        ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].ecommerce.paymentCheckout.shipping.set(shippingObj);
        log('GTM AT Internet Template - Payment Checkout (Sales Insights) - Shipping - OK', shippingObj);
      }
    }    

    pixel.dispatch(); 
  },
  // Set Cart Awaiting Payment (Sales Insights)
  cartAwaitingPayment: () => {
    const ATInternet = copyFromWindow('ATInternet');
    const cartObj = setDefinedObject({
      'id': cartId,
      'currency': currency,
      'turnovertaxincluded': turnoverTaxIncluded,
      'turnovertaxfree': turnoverTaxFree,
      'creation_utc': creation_utc,
      'quantity': quantity,
      'nbdistinctproduct': nbDistinctProduct
    });
    const shippingObj = setDefinedObject({
      'delivery': delivery,
      'costtaxincluded': costTaxIncluded,
      'costtaxfree': costTaxFree
    });
    const transactionObj = setDefinedObject({
      'promocode': promoCode,
      'firstpurchase': firstPurchase
    });
    
    if(ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].ecommerce){
      if(cartObj) {
        ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].ecommerce.cartAwaitingPayment.cart.set(cartObj);
        log('GTM AT Internet Template - Cart Awaiting Payment (Sales Insights) - Cart - OK', cartObj);
      }
      if(products.length > 0) {
        ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].ecommerce.cartAwaitingPayment.products.set(products);
        log('GTM AT Internet Template - Cart Awaiting Payment (Sales Insights) - Products - OK', products);
      }
      if(shippingObj) {
        ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].ecommerce.paymentCheckout.shipping.set(shippingObj);
        log('GTM AT Internet Template - Cart Awaiting Payment (Sales Insights) - Shipping - OK', shippingObj);
      }
      if(paymentMode) {
        ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].ecommerce.cartAwaitingPayment.payment.set({
          'mode': paymentMode
        });
        log('GTM AT Internet Template - Cart Awaiting Payment (Sales Insights) - Payment Mode - OK', paymentMode);
      }
      if(transactionObj) {
        ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].ecommerce.cartAwaitingPayment.transaction.set(transactionObj);
        log('GTM AT Internet Template - Cart Awaiting Payment (Sales Insights) - Transaction - OK', transactionObj);
      }
    }

    pixel.dispatch(); 
  },
  // Set Transaction Confirmation (Sales Insights)
  transactionConfirmation: () => {
    const ATInternet = copyFromWindow('ATInternet');
    const cartObj = setDefinedObject({
      'id': cartId,
      'currency': currency,
      'turnovertaxincluded': turnoverTaxIncluded,
      'turnovertaxfree': turnoverTaxFree,
      'creation_utc': creation_utc,
      'quantity': quantity,
      'nbdistinctproduct': nbDistinctProduct
    });
    const shippingObj = setDefinedObject({
      'delivery': delivery,
      'costtaxincluded': costTaxIncluded,
      'costtaxfree': costTaxFree
    });
    const transactionObj = setDefinedObject({
      'id': transactionId,
      'status': transactionStatus,
      'promocode': promoCode,
      'firstpurchase': firstPurchase
    });
    
    if(ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].ecommerce){
      if(cartObj) {
        ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].ecommerce.transactionConfirmation.cart.set(cartObj);
        log('GTM AT Internet Template - Transaction Confirmation (Sales Insights) - Cart - OK', cartObj);
      }
      if(products.length > 0) {
        ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].ecommerce.transactionConfirmation.products.set(products);
        log('GTM AT Internet Template - Transaction Confirmation (Sales Insights) - Products - OK', products);
      }
      if (shippingObj) {
        ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].ecommerce.transactionConfirmation.shipping.set(shippingObj);
        log('GTM AT Internet Template - Transaction Confirmation (Sales Insights) - Shipping - OK', shippingObj);
      }
      if (paymentMode) {
        ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].ecommerce.transactionConfirmation.payment.set({
          'mode': paymentMode
        });
        log('GTM AT Internet Template - Transaction Confirmation (Sales Insights) - Payment Mode - OK', paymentMode);
      }
      ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].ecommerce.transactionConfirmation.transaction.set(transactionObj);
    log('GTM AT Internet Template - Transaction Confirmation (Sales Insights) - Transaction - OK', transactionObj);
    }

    pixel.dispatch(); 
  },
  // Send pixel
  dispatch: () => {
    let ATInternet = copyFromWindow('ATInternet');
    // Consent
    const consent = atInternetSettings.consent;
    const visitorMode = ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].privacy.getVisitorMode();
    if (visitorMode) {
    if(consent === 'optin' && visitorMode.name !== 'optout' && visitorMode.name !== 'optin')
    {
     ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].privacy.setVisitorOptin();
    }
    else if (consent !== 'optin' && visitorMode.name !== 'optout' && visitorMode.name !== 'optin') {
      ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].privacy.setVisitorMode("cnil", "exempt");
    }
    }
    else {
       if(consent === 'optin')
    {
     ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].privacy.setVisitorOptin();
    }
    else {
      ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].privacy.setVisitorMode("cnil", "exempt");
    }
    }
    ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].dispatch(); 
    log('GTM AT Internet Template - Dispatch - OK');
    log('Visitor Mode' + ATInternet.Tracker.instances[ATInternet.Tracker.instances.length-1].privacy.getVisitorMode().name);
  }
};

const setDefinedObject = (obj1, obj2) => {
  let tmpObj = {};
  for(let key in obj1){
    if(!!obj1[key]) {
      if(obj1[key] === 'true' || obj1[key] === 'false'){
        tmpObj[key] = !!obj1[key];
      } 
      else {
        tmpObj[key] = obj1[key];  
      }
    }
  }
  for(let key in obj2){
    if(!!obj2[key]) {
      if(obj2[key] === 'true' || obj2[key] === 'false'){
        tmpObj[key] = !!obj2[key];
      } 
      else {
        tmpObj[key] = obj2[key];  
      }
    }
  }
  for(var key in tmpObj) {
    if(tmpObj.hasOwnProperty(key)) {
      return tmpObj;
    }
  }  
  return false; 
};

injectScript(smarttagURL, pixel.init, data.gtmOnFailure, 'pixelAT');
