using System;
using Xunit;

namespace WebUI.Test
{
    public class UnitTest1
    {
        [Fact]
        public void Test1()
        {
            int value = 2 + 2;

            Assert.Equal(4, value);
        }
    }
}
