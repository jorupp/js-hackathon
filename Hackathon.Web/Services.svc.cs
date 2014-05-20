using System;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.ServiceModel.Web;

namespace Hackathon.Web
{
    [ServiceContract(Namespace = "")]
    [AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
    public class Services
    {
        // Add [WebGet] attribute to use HTTP GET
        [OperationContract]
        [WebGet(BodyStyle = WebMessageBodyStyle.Bare, ResponseFormat = WebMessageFormat.Json)]
        public X[] GetData()
        {
            return new X[] 
            {
                new X { x = 1, y = 2 },
            };
        }

        public class X
        {
            public int x { get; set; }
            public int y { get; set; }
        }
    }
}
