<%-- 
    Document   : product_details
    Created on : Dec 20, 2024
    Author     : lvhho
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Perfume Paradise Store</title>
        <link rel="icon" href="images/logo1.png"/>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.2.1/assets/owl.carousel.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.2.1/assets/owl.theme.default.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/css/nice-select.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>
        <link rel="stylesheet" href="https://cdn.tailwindcss.com/3.3.2"/>
        <script src="https://cdn.jsdelivr.net/gh/alpinejs/alpine@v2.x.x/dist/alpine.min.js" defer></script>
        <style type="text/css">
            .product-details {
                margin: 100px 60px;
            }
            .product-image {
                max-width: 100%;
                height: auto;
                border-radius: 10px;
            }
            .product-info {
                margin-top: 20px;
                padding: 20px;
                background: #f9f9f9;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            .product-info h2 {
                margin-bottom: 20px;
                font-size: 28px;
                font-weight: bold;
                color: #333;
            }
            .product-info p {
                margin-bottom: 10px;
                font-size: 16px;
                color: #555;
            }
            .product-info .price {
                color: #ff5722;
                font-size: 24px;
                font-weight: bold;
            }
            li a:hover {
                color: #f6692a;
            }
            ul li a.active {
                color: #f6692a;
            }

            .li_header {
                color: white;
                margin-left: 50px;
                font-size: 18px;
            }

            .submit-price {
                font-size: 16px;
                background-color: black;
                color: white;
                font-weight: 600;
                padding: 5px 40px;
                border-radius: 20px;
                margin: 10px 0 20px;
                border: none;
            }

            .submit-price:hover {
                background-color: rgba(0,0,0,0.3);
                color: black;
                font-weight: 600;
            }

            .header_container {
                padding: 10px 0;
                background-color: #fff;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .header_container .logo img {
                max-height: 50px;
            }

            .main_menu nav ul {
                display: flex;
                list-style: none;
                padding: 0;
            }

            .main_menu nav ul li {
                margin-right: 30px;
            }

            .main_menu nav ul li a {
                color: #333;
                font-size: 16px;
                font-weight: 600;
                text-transform: uppercase;
            }

            .main_menu nav ul li a:hover {
                color: #f6692a;
            }

            .main_menu nav ul li .mega_menu {
                background: #fff;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
            }

            .mega_menu_inner li a {
                color: #333;
            }

            .mega_menu_inner li a:hover {
                color: #f6692a;
            }

            .product-actions {
                margin-top: 20px;
                padding: 20px;
                background: #f1f1f1;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .product-actions h2 {
                margin-bottom: 20px;
                font-size: 24px;
                color: #333;
            }

            .product-actions form input,
            .product-actions form select,
            .product-actions form button {
                margin-bottom: 10px;
                width: 100%;
                padding: 10px;
                border-radius: 5px;
                border: 1px solid #ddd;
            }

            .product-actions form button {
                background-color: #333;
                color: white;
                border: none;
                font-weight: bold;
                cursor: pointer;
            }

            .product-actions form button:hover {
                background-color: #ff5722;
                color: white;
            }
        </style>
    </head>
    <body class="stretched no-transition">
        <header>
            <div class="main_header header_transparent header-mobile-m" style="margin: 0">
                <div class="header_container sticky-header" style="background: #1c1d22;">
                    <div class="container-fluid">
                        <div class="row align-items-center">
                            <div class="col-lg-2">
                                <div class="logo">
                                    <a href="home"><img src="images/logo.png" alt=""></a>
                                </div>
                            </div>

                            <div class="col-lg-6">
                                <!-- main-menu starts -->
                                <div class="main_menu menu_two menu_position">
                                    <nav>
                                        <ul>
                                            <li class="mega_items">
                                                <a href="#">Collections <i class="fa fa-angle-down"></i></a>
                                                <div class="mega_menu">
                                                    <ul  class="mega_menu_inner">
                                                        <li style="color: black; font-size: 16px">
                                                            <a class="a" href="refine?cid_refine=${0}">ALL</a>
                                                        </li>
                                                        <c:forEach items="${requestScope.category}" var="c">
                                                            <li style=" font-size: 16px">
                                                                <a class="a" href="refine?cid_refine=${c.id}">${c.name}</a>
                                                            </li>
                                                        </c:forEach>
                                                    </ul>
                                                </div>
                                            </li>
                                            <li><a href="aboutus">About Us</a></li>
                                            <li><a href="contact" >Contact Us</a></li>
                                            <c:if test="${sessionScope.account==null}">
                                                <li>
                                                    <a href="#">User <i class="fa fa-angle-down"></i></a>
                                                    <ul class="sub_menu pages">
                                                        <li><a href="login">Login In</a></li>
                                                        <li><a href="register">Sign Up</a></li>
                                                    </ul>
                                                </li>
                                            </c:if>
                                            <c:if test="${sessionScope.account!=null}">
                                                <li>
                                                    <a href="profile">Profile</a> 
                                                </li>
                                            </c:if>
                                        </ul>
                                    </nav>
                                </div>
                                <!-- main menu ends -->
                            </div>
                            <div class="col-lg-4">
                                <%@ include file="header_right.jsp"%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <section id="content">
            <div class="content-wrap">
                <div class="container">
                    <div class="row product-details">
                        <div class="col-md-6">
                            <!-- Carousel container -->
                            <div class="owl-carousel owl-theme">
                                <c:forEach var="image" items="${product.image}">
                                    <div class="item">
                                        <img class="product-image" src="${image}" alt="${product.name}">
                                    </div>
                                </c:forEach>
                            </div>
                            <!-- Thumbnail navigation -->
                            <div class="owl-thumbs">
                                <c:forEach var="image" items="${product.image}">
                                    <button class="owl-thumb-item">
                                        <img src="${image}" style="width: 50px; height: 50px;" alt="${product.name}">
                                    </button>
                                </c:forEach>
                            </div>
                        </div>
                        <div class="col-md-6 product-info">
                            <h2>${product.name}</h2>
                            <p>${product.describe}</p>
                            <p>Quantity Per Unit: ${product.quantity}</p>
                            <p>Discount: ${product.discount}%</p>
                            <div class="product_rating">
                            <ul>
                                <c:set var="numstar" value="${product.starRating}"/>
                                    <c:forEach begin="1" end="${numstar}" step="1">
                                        <li>
                                            <a href="#" style="color: orange">
                                                <i class="fa fa-star"></i>
                                            </a>
                                       </li>
                                    </c:forEach>
                                <c:if test="${numstar != 5}">
                            <c:forEach begin="${numstar + 1}" end="5" step="1">
                            <li>
                            <a href="#" style="color: black">
                            <i class="fa fa-star"></i>
                            </a>
                            </li>
                            </c:forEach>
                             </c:if>
                            </ul>
                            </div>
                            <div class="modal_price mb-10">
                                <span class="new_price" style="font-size: 30px;">Rs. ${product.salePrice}$</span>
                                <c:if test="${product.price != product.salePrice}">
                                    <span class="old_price">Rs. ${product.price}$</span>
                                </c:if>
                            </div>
                            <p>Hãng: ${product.supplier.companyName} - Nước: ${product.supplier.country}</p>
                           <div class="row product-actions">
                        <div class="col-md-12">
                            <h2>Select Options</h2>
                            <form>
                                <label for="variants_fragrance" class="form-label">Size</label>
                                <select id="variants_fragrance" class="form-select" style="padding: 10px 0">
                                    <c:forEach var="quantity" items="${fn:split(product.classifyStr, ' ')}">
                                        <option value="${quantity}">${quantity}</option>
                                    </c:forEach>
                                </select>
                                <label for="quantity" class="form-label">Quantity</label>
                                <input id="quantity" name="quantity" type="number" min="1" max="100" step="1" value="1" class="form-control">
                                <input id="id" name="id" type="hidden" value="${product.id}">
                                <input id="role" name="role" type="hidden" value="add">
                                <button onclick="loadProductCart(this)" type="button" class="btn btn-dark">Add to cart</button>
                            </form>
                        </div>
                    </div>
                        </div>
                    </div>
                    
                </div>
            </div>
        </section>
        <jsp:include page="footer.jsp"/>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>   
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.2.1/owl.carousel.min.js"></script>
        <script src="js/clickevents.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/js/jquery.nice-select.min.js"></script>
        <script src="js/main.js"></script>
        <script>
            $(document).ready(function(){
                $(".owl-carousel").owlCarousel({
                    items: 1,
                    loop: true,
                    autoplay: true,
                    autoplayTimeout: 3000,
                    autoplayHoverPause: true,
                    nav: true,
                    dots: true,
                    thumb: true,
                    thumbImage: true,
                    thumbContainerClass: 'owl-thumbs',
                    thumbItemClass: 'owl-thumb-item'
                });
            });
        </script>
    </body>
</html>