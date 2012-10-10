package com.hugeinc.solr;

import org.apache.solr.SolrTestCaseJ4;
import org.junit.BeforeClass;
import org.junit.Ignore;

@Ignore
public class RestaurantCoreSolrTest extends SolrTestCaseJ4 {

  @BeforeClass
  public static void beforeClass() throws Exception {
    initCore("solrconfig.xml", "schema.xml", "solr/barcore");
    creatTestRestaurantData();
  }

  private static void creatTestRestaurantData() {

  }

  @Override
  public void setUp() throws Exception {
    super.setUp();
    /*
    JavaBinUpdateRequestCodec codec = new JavaBinUpdateRequestCodec();
    File restaurants = new File("src/test/resources/restaurantData.javabin");
    FileInputStream fis = new FileInputStream(restaurants);

    final List<SolrInputDocument> doc = Lists.newArrayList();
    UpdateRequest request2 = codec.unmarshal(fis, new StreamingUpdateHandler() {
      @Override
      public void update(SolrInputDocument document, UpdateRequest req) {
        req.add(document);
        doc.add(document);
      }
    });
    assertU(request2.getXML());
    assertU(commit());
    */
  }

}
