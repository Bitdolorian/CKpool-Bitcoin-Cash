import './globals.css';
import { Metadata } from 'next';
import { Lato } from 'next/font/google';

import Footer from '../components/Footer';
import Header from '../components/Header';
import Providers from '../components/Providers';
import { RefreshProvider } from '../lib/contexts/RefreshContext';

const lato = Lato({ subsets: ['latin'], weight: ['400', '700'] });

export const metadata: Metadata = {
  title: 'CKstats',
  description:
    'Real-time and historical statistics for the CKPool Bitcoin mining pool using data from their API.',
  icons: {
    icon: '/icon.png',
  },
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <head>
        <script
          dangerouslySetInnerHTML={{
            __html: `
              try {
                const defaultTheme = ${JSON.stringify(
                  process.env.NEXT_PUBLIC_DEFAULT_THEME || 'dark'
                )};
                const theme = localStorage.getItem('theme') || defaultTheme;
                document.documentElement.setAttribute('data-theme', theme);
              } catch (e) {
                document.documentElement.setAttribute(
                  'data-theme',
                  ${JSON.stringify(
                    process.env.NEXT_PUBLIC_DEFAULT_THEME || 'dark'
                  )}
                );
              }
            `,
          }}
        />
      </head>
      <body className={lato.className}>
        <Providers>
          <RefreshProvider>
            <div className="flex flex-col min-h-screen">
              <Header />
              <main className="flex-grow">{children}</main>
              <Footer />
            </div>
          </RefreshProvider>
        </Providers>
      </body>
    </html>
  );
}
