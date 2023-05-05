<x-link class="layout-navbar-fixed layout-fixed  layout-footer-fixed"></x-link>
{{-- Fixed Navbar = layout-navbar-fixed --}}
{{-- Fixed Sidebar = layout-fixed --}}
{{-- Fixed Footer = layout-footer-fixed --}}
<div class="wrapper">
    <x-navbar.navbar></x-navbar.navbar>
    <x-sidebar.sidebar></x-sidebar.sidebar>
    <x-navbar.footer></x-navbar.footer>
    <section class="content-wrapper">
        <div class="container-fluid">
            <h5 class="mb-2">Info Box</h5>
            <div class="row">
                <x-cards.sm-card bgcolor='bg-info' icon="fas fa-home" msg1='Home' msg2='10001' />
                <x-cards.sm-card bgcolor='bg-success' icon="fas fa-envelope" msg1='Message' msg2='10001' />
                {{-- <x-cards.sm-card/> --}}

            </div>
            <div class="row">
                <x-cards.xl-card icon='fas fa-shopping-cart' bgcolor="bg-warning" total='50' text1='hello'/>
                <x-cards.xl-card icon='fas fa-user-plus' bgcolor="bg-danger" total='50' text1='hello'/>
            </div>
        </div>
    </section>

</div>
